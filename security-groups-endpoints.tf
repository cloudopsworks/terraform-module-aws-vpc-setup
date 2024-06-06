##
# (c) 2024 - Cloud Ops Works LLC - https://cloudops.works/
#            On GitHub: https://github.com/cloudopsworks
#            Distributed Under Apache v2.0 License
#

resource "aws_security_group" "endpoints" {
  provider    = aws.default
  name        = "vpc-endpoints-sg-${local.system_name}"
  description = "Security group for Endpoints access"
  vpc_id      = module.vpc.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(local.all_tags, tomap({
    "Name" = "vpc-endpoints-sg-${local.system_name}"
  }))
}



### All VPC Access
resource "aws_security_group_rule" "endpoints_ingress" {
  provider          = aws.default
  security_group_id = aws_security_group.endpoints.id
  description       = "Allow All Access from VPC"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = [module.vpc.vpc_cidr_block]
  type              = "ingress"
}
