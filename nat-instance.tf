##
# (c) 2021-2025
#     Cloud Ops Works LLC - https://cloudops.works/
#     Find us on:
#       GitHub: https://github.com/cloudopsworks
#       WebSite: https://cloudops.works
#     Distributed Under Apache v2.0 License
#

data "aws_ami" "amazon_linux_2023" {
  count       = local.use_nat_instance ? 1 : 0
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*"] # Or arm64 for Graviton instances
  }

  filter {
    name = "architecture"
    values = ["arm64"]
  }
}

resource "aws_eip" "nat_ec2_instance" {
  count = local.use_nat_instance ? 1 : 0
  tags = merge(local.all_tags, {
    Name = "nat-instance-eip-${local.system_name}"
  })
}

resource "aws_eip_association" "nat_ec2_instance" {
  count                = local.use_nat_instance ? 1 : 0
  allocation_id        = aws_eip.nat_ec2_instance[0].id
  network_interface_id = aws_network_interface.nat_ec2_instance[0].id
}

resource "aws_network_interface" "nat_ec2_instance" {
  count             = local.use_nat_instance ? 1 : 0
  security_groups   = [aws_security_group.ssh_admin.id, aws_security_group.bastion.id]
  subnet_id         = module.vpc.public_subnets[0] # Use the first public subnet for NAT
  source_dest_check = false
  description       = "ENI for NAT instance nat-instance-${local.system_name}"
  tags = merge(local.all_tags, {
    Name = "nat-instance-${local.system_name}"
  })
}

resource "aws_instance" "nat_ec2_instance" {
  count                = local.use_nat_instance ? 1 : 0
  ami                  = data.aws_ami.amazon_linux_2023[0].id
  instance_type        = var.nat_instance_size # Or other suitable type
  iam_instance_profile = aws_iam_instance_profile.bastion.name
  user_data            = <<-EOF
    #!/bin/bash
    yum install iptables-services -y
    echo "net.ipv4.ip_forward=1" >> /etc/sysctl.d/90-nat.conf
    sysctl --system
    iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
    iptables-save > /etc/sysconfig/iptables
  EOF

  network_interface {
    device_index         = 0
    network_interface_id = aws_network_interface.nat_ec2_instance[0].id
  }

  root_block_device {
    volume_size           = 30
    delete_on_termination = true
    volume_type           = "gp3"
  }

  volume_tags = merge(local.all_tags, {
    Name = "nat-instance-${local.system_name}"
  })
  tags = merge(local.all_tags, {
    Name = "nat-instance-${local.system_name}"
  })
}

resource "aws_route" "nat_instance_route_private" {
  count                  = local.use_nat_instance ? length(module.vpc.private_route_table_ids) : 0
  route_table_id         = element(module.vpc.private_route_table_ids, count.index)
  destination_cidr_block = "0.0.0.0/0"
  network_interface_id   = aws_network_interface.nat_ec2_instance[0].id
}

resource "aws_route" "nat_instance_route_database" {
  count                  = local.use_nat_instance ? length(module.vpc.database_route_table_ids) : 0
  route_table_id         = element(module.vpc.database_route_table_ids, count.index)
  destination_cidr_block = "0.0.0.0/0"
  network_interface_id   = aws_network_interface.nat_ec2_instance[0].id
}

resource "aws_route" "nat_instance_route_intra" {
  count                  = local.use_nat_instance ? length(module.vpc.intra_route_table_ids) : 0
  route_table_id         = element(module.vpc.intra_route_table_ids, count.index)
  destination_cidr_block = "0.0.0.0/0"
  network_interface_id   = aws_network_interface.nat_ec2_instance[0].id
}