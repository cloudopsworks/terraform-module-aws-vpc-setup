##
# (c) 2024 - Cloud Ops Works LLC - https://cloudops.works/
#            On GitHub: https://github.com/cloudopsworks
#            Distributed Under Apache v2.0 License
#

resource "aws_security_group" "bastion" {
  name        = "bastion-vm-${local.system_name}-sg"
  description = "Security group for Bastion access to any resource"
  vpc_id      = module.vpc.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(local.all_tags, tomap({
    "Name" = "bastion-vm-${local.system_name}-sg"
  }))
  lifecycle {
    create_before_destroy = true
  }
}

