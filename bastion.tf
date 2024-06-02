##
# (c) 2024 - Cloud Ops Works LLC - https://cloudops.works/
#            On GitHub: https://github.com/cloudopsworks
#            Distributed Under Apache v2.0 License
#
resource "tls_private_key" "keypair_gen_bastion" {
  count = var.create_bastion ? 1 : 0

  algorithm = "RSA"
  rsa_bits  = "4096"
}

resource "local_file" "keypair_priv_bastion" {
  count = var.create_bastion ? 1 : 0

  content  = tls_private_key.keypair_gen_bastion[count.index].private_key_pem
  filename = "pem-files/key-${local.system_name}-${local.region}.pem"
}

resource "aws_key_pair" "bastion_key" {
  count = var.create_bastion ? 1 : 0

  key_name   = "key/bastion-${local.system_name}"
  public_key = tls_private_key.keypair_gen_bastion[count.index].public_key_openssh
}


output "bastion_key" {
  value = tls_private_key.keypair_gen_bastion.*.public_key_openssh
}

data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-*-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

data "cloudinit_config" "prometheus_server_cloudinit" {
  gzip          = false
  base64_encode = true

  part {
    content_type = "text/cloud-config"
    content      = "hostname: bastion-vm-${local.system_name}\nmanage_etc_hosts: true"
  }

  part {
    content_type = "text/x-shellscript"
    content = templatefile("${path.module}/files/userdata_server_dockeronly", {
      docker_version_server = var.docker_version_server
    })
  }
}

resource "aws_instance" "bastion_server" {
  count = var.create_bastion ? 1 : 0

  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.bastion_size
  key_name               = aws_key_pair.bastion_key[count.index].key_name
  vpc_security_group_ids = [aws_security_group.ssh_admin.id, aws_security_group.bastion.id]
  user_data              = data.cloudinit_config.prometheus_server_cloudinit.rendered
  subnet_id              = module.vpc.public_subnets[0]
  source_dest_check      = true
  iam_instance_profile   = aws_iam_instance_profile.bastion.name

  root_block_device {
    volume_size           = var.bastion_storage
    delete_on_termination = true
  }

  lifecycle {
    ignore_changes = [
      user_data,
      ami,
    ]
  }

  tags = merge(local.all_tags, {
    Name = "bastion-vm-${local.system_name}"
    Role = "Bastion"
  })

  volume_tags = merge(local.all_tags, {
    Name = "bastion-vm-${local.system_name}"
    Role = "Bastion"
  })
}



resource "aws_iam_role" "bastion" {
  name               = "bastion-vm-role-${local.system_name}"
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY

}

resource "aws_iam_instance_profile" "bastion" {
  name = "bastion-vm-role-${local.system_name}"
  role = aws_iam_role.bastion.name

}

resource "aws_iam_role_policy_attachment" "bastion_admin" {
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
  role       = aws_iam_role.bastion.name
}



output "bastion_public_address" {
  value = aws_instance.bastion_server.*.public_dns
}

output "bastion_public_ip" {
  value = aws_instance.bastion_server.*.public_ip
}
