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
    values = ["al2023-ami-*-x86_64"] # Or arm64 for Graviton instances
  }
}

resource "aws_instance" "nat_ec2_instance" {
  count                  = local.use_nat_instance ? 1 : 0
  ami                    = data.aws_ami.amazon_linux_2023[0].id
  instance_type          = var.nat_instance_size        # Or other suitable type
  subnet_id              = module.vpc.public_subnets[0] # Use the first public subnet for NAT
  vpc_security_group_ids = [aws_security_group.ssh_admin.id, aws_security_group.bastion.id]
  iam_instance_profile   = aws_iam_instance_profile.bastion.name
  source_dest_check      = false # Essential for a NAT device
  user_data              = <<-EOF
    #!/bin/bash
    yum install iptables-services -y
    echo "net.ipv4.ip_forward=1" >> /etc/sysctl.d/90-nat.conf
    sysctl --system
    iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
    iptables-save > /etc/sysconfig/iptables
  EOF

  root_block_device {
    volume_size           = 8
    delete_on_termination = true
  }

  volume_tags = merge(local.all_tags, {
    Name = "nat-instance-${local.system_name}"
  })
  tags = merge(local.all_tags, {
    Name = "nat-instance-${local.system_name}"
  })
}