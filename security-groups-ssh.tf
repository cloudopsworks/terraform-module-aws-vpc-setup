##
# (c) 2024 - Cloud Ops Works LLC - https://cloudops.works/
#            On GitHub: https://github.com/cloudopsworks
#            Distributed Under Apache v2.0 License
#

resource "aws_security_group" "ssh_admin" {
  name        = "sshadmin-sg-${local.system_name}"
  description = "Security group for SSH access in "
  vpc_id      = module.vpc.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(local.all_tags, tomap({
    "Name" = "sshadmin-sg-${local.system_name}"
  }))
}



### VPN Access
resource "aws_security_group_rule" "ssh-admin-ingress-vpn" {
  count             = length(var.vpn_accesses) > 0 ? 1 : 0
  description       = "Allow SSH Access from VPN"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  security_group_id = aws_security_group.ssh_admin.id
  cidr_blocks       = var.vpn_accesses
  type              = "ingress"
}
