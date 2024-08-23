##
# (c) 2024 - Cloud Ops Works LLC - https://cloudops.works/
#            On GitHub: https://github.com/cloudopsworks
#            Distributed Under Apache v2.0 License
#

resource "aws_security_group" "endpoints" {
  name        = "vpc-${local.system_name}-endpoints-sg"
  description = "Security group for Endpoints access"
  vpc_id      = module.vpc.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(local.all_tags, tomap({
    "Name" = "vpc-${local.system_name}-endpoints-sg"
  }))
  lifecycle {
    create_before_destroy = true
  }
}



### All VPC Access
resource "aws_security_group_rule" "endpoints_ingress" {
  security_group_id = aws_security_group.endpoints.id
  description       = "Allow All Access from VPC"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = [module.vpc.vpc_cidr_block]
  type              = "ingress"
}
