
resource "aws_security_group" "bastion" {
  name        = "bastion-vm-sg-${local.system_name}"
  description = "Security group for Bastion access to any resource"
  vpc_id      = module.vpc.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(local.all_tags, tomap({
    "Name" = "bastion-vm-sg-${local.system_name}"
  }))
}

