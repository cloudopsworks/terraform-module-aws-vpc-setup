##
# (c) 2024 - Cloud Ops Works LLC - https://cloudops.works/
#            On GitHub: https://github.com/cloudopsworks
#            Distributed Under Apache v2.0 License
#

resource "aws_network_acl_rule" "custom_public_acl_rule" {
  count          = length(var.public_acl_rules) * (length(var.public_subnets) > 0 ? 1 : 0)
  network_acl_id = module.vpc.public_network_acl_id
  rule_number    = count.index + 1000
  egress         = false
  cidr_block     = var.public_acl_rules[count.index].cidr_block
  protocol       = var.public_acl_rules[count.index].protocol
  rule_action    = var.public_acl_rules[count.index].rule_action
  from_port      = var.public_acl_rules[count.index].from_port
  to_port        = var.public_acl_rules[count.index].to_port
}

resource "aws_network_acl_rule" "custom_public_outbound_acl_rule" {
  count          = length(var.public_outbound_rules) * (length(var.public_subnets) > 0 ? 1 : 0)
  network_acl_id = module.vpc.public_network_acl_id
  rule_number    = count.index + 1000
  egress         = true
  cidr_block     = var.public_outbound_rules[count.index].cidr_block
  protocol       = var.public_outbound_rules[count.index].protocol
  rule_action    = var.public_outbound_rules[count.index].rule_action
  from_port      = var.public_outbound_rules[count.index].from_port
  to_port        = var.public_outbound_rules[count.index].to_port
}

resource "aws_network_acl_rule" "custom_private_acl_rule" {
  count          = length(var.private_acl_rules)
  network_acl_id = module.vpc.private_network_acl_id
  rule_number    = count.index + 1000
  egress         = false
  cidr_block     = var.public_acl_rules[count.index].cidr_block
  protocol       = var.public_acl_rules[count.index].protocol
  rule_action    = var.public_acl_rules[count.index].rule_action
  from_port      = var.public_acl_rules[count.index].from_port
  to_port        = var.public_acl_rules[count.index].to_port
}

resource "aws_network_acl_rule" "private_acl_rules_in_for_internal" {
  count          = length(var.internal_allow_cidrs)
  network_acl_id = module.vpc.private_network_acl_id
  rule_number    = count.index + 1500
  egress         = false
  cidr_block     = var.internal_allow_cidrs[count.index]
  protocol       = "-1"
  rule_action    = "allow"
  from_port      = 0
  to_port        = 0
}

resource "aws_network_acl_rule" "private_acl_rules_out_for_internal" {
  count          = length(var.internal_allow_cidrs)
  network_acl_id = module.vpc.private_network_acl_id
  rule_number    = count.index + 1500
  egress         = true
  cidr_block     = var.internal_allow_cidrs[count.index]
  protocol       = "-1"
  rule_action    = "allow"
  from_port      = 0
  to_port        = 0
}

resource "aws_network_acl_rule" "public_acl_rules_in_for_internal" {
  count          = length(var.internal_allow_cidrs) * (length(var.public_subnets) > 0 ? 1 : 0)
  network_acl_id = module.vpc.public_network_acl_id
  rule_number    = count.index + 1500
  egress         = false
  cidr_block     = var.internal_allow_cidrs[count.index]
  protocol       = "-1"
  rule_action    = "allow"
  from_port      = 0
  to_port        = 0
}

resource "aws_network_acl_rule" "public_acl_rules_out_for_internal" {
  count          = length(var.internal_allow_cidrs) * (length(var.public_subnets) > 0 ? 1 : 0)
  network_acl_id = module.vpc.public_network_acl_id
  rule_number    = count.index + 1500
  egress         = true
  cidr_block     = var.internal_allow_cidrs[count.index]
  protocol       = "-1"
  rule_action    = "allow"
  from_port      = 0
  to_port        = 0
}

resource "aws_network_acl_rule" "db_acl_rules_in_for_internal" {
  count          = module.vpc.database_network_acl_id != "" ? length(var.internal_allow_cidrs) : 0
  network_acl_id = module.vpc.database_network_acl_id
  rule_number    = count.index + 1500
  egress         = false
  cidr_block     = var.internal_allow_cidrs[count.index]
  protocol       = "-1"
  rule_action    = "allow"
  from_port      = 0
  to_port        = 0
}

resource "aws_network_acl_rule" "db_acl_rules_out_for_internal" {
  count          = module.vpc.database_network_acl_id != "" ? length(var.internal_allow_cidrs) :0
  network_acl_id = module.vpc.database_network_acl_id
  rule_number    = count.index + 1500
  egress         = true
  cidr_block     = var.internal_allow_cidrs[count.index]
  protocol       = "-1"
  rule_action    = "allow"
  from_port      = 0
  to_port        = 0
}