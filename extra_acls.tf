##
# (c) 2021-2025
#     Cloud Ops Works LLC - https://cloudops.works/
#     Find us on:
#       GitHub: https://github.com/cloudopsworks
#       WebSite: https://cloudops.works
#     Distributed Under Apache v2.0 License
#

resource "aws_network_acl_rule" "custom_public_acl_rule" {
  count          = length(var.vpc.acl_rules.public) * (length(var.vpc.subnet_cidr_blocks.public) > 0 ? 1 : 0)
  network_acl_id = module.vpc.public_network_acl_id
  rule_number    = count.index + 1000
  egress         = false
  cidr_block     = var.vpc.acl_rules.public[count.index].cidr_block
  protocol       = var.vpc.acl_rules.public[count.index].protocol
  rule_action    = var.vpc.acl_rules.public[count.index].rule_action
  from_port      = var.vpc.acl_rules.public[count.index].from_port
  to_port        = var.vpc.acl_rules.public[count.index].to_port
}

resource "aws_network_acl_rule" "custom_public_outbound_acl_rule" {
  count          = length(var.vpc.acl_rules.public_outbound) * (length(var.vpc.subnet_cidr_blocks.public) > 0 ? 1 : 0)
  network_acl_id = module.vpc.public_network_acl_id
  rule_number    = count.index + 1000
  egress         = true
  cidr_block     = var.vpc.acl_rules.public_outbound[count.index].cidr_block
  protocol       = var.vpc.acl_rules.public_outbound[count.index].protocol
  rule_action    = var.vpc.acl_rules.public_outbound[count.index].rule_action
  from_port      = var.vpc.acl_rules.public_outbound[count.index].from_port
  to_port        = var.vpc.acl_rules.public_outbound[count.index].to_port
}

resource "aws_network_acl_rule" "custom_private_acl_rule" {
  count          = length(var.vpc.acl_rules.private)
  network_acl_id = module.vpc.private_network_acl_id
  rule_number    = count.index + 1000
  egress         = false
  cidr_block     = var.vpc.acl_rules.private[count.index].cidr_block
  protocol       = var.vpc.acl_rules.private[count.index].protocol
  rule_action    = var.vpc.acl_rules.private[count.index].rule_action
  from_port      = var.vpc.acl_rules.private[count.index].from_port
  to_port        = var.vpc.acl_rules.private[count.index].to_port
}

resource "aws_network_acl_rule" "private_acl_rules_in_for_internal" {
  count          = length(var.vpc.internal_allow_cidrs)
  network_acl_id = module.vpc.private_network_acl_id
  rule_number    = count.index + 1500
  egress         = false
  cidr_block     = var.vpc.internal_allow_cidrs[count.index]
  protocol       = "-1"
  rule_action    = "allow"
  from_port      = 0
  to_port        = 0
}

resource "aws_network_acl_rule" "private_acl_rules_out_for_internal" {
  count          = length(var.vpc.internal_allow_cidrs)
  network_acl_id = module.vpc.private_network_acl_id
  rule_number    = count.index + 1500
  egress         = true
  cidr_block     = var.vpc.internal_allow_cidrs[count.index]
  protocol       = "-1"
  rule_action    = "allow"
  from_port      = 0
  to_port        = 0
}

resource "aws_network_acl_rule" "public_acl_rules_in_for_internal" {
  count          = length(var.vpc.internal_allow_cidrs) * (length(var.vpc.subnet_cidr_blocks.public) > 0 ? 1 : 0)
  network_acl_id = module.vpc.public_network_acl_id
  rule_number    = count.index + 1500
  egress         = false
  cidr_block     = var.vpc.internal_allow_cidrs[count.index]
  protocol       = "-1"
  rule_action    = "allow"
  from_port      = 0
  to_port        = 0
}

resource "aws_network_acl_rule" "public_acl_rules_out_for_internal" {
  count          = length(var.vpc.internal_allow_cidrs) * (length(var.vpc.subnet_cidr_blocks.public) > 0 ? 1 : 0)
  network_acl_id = module.vpc.public_network_acl_id
  rule_number    = count.index + 1500
  egress         = true
  cidr_block     = var.vpc.internal_allow_cidrs[count.index]
  protocol       = "-1"
  rule_action    = "allow"
  from_port      = 0
  to_port        = 0
}

resource "aws_network_acl_rule" "db_acl_rules_in_for_internal" {
  depends_on     = [module.vpc]
  count          = length(var.vpc.subnet_cidr_blocks.database) > 0 ? length(var.vpc.internal_allow_cidrs) : 0
  network_acl_id = module.vpc.database_network_acl_id
  rule_number    = count.index + 1500
  egress         = false
  cidr_block     = var.vpc.internal_allow_cidrs[count.index]
  protocol       = "-1"
  rule_action    = "allow"
  from_port      = 0
  to_port        = 0
}

resource "aws_network_acl_rule" "db_acl_rules_out_for_internal" {
  depends_on     = [module.vpc]
  count          = length(var.vpc.subnet_cidr_blocks.database) > 0 ? length(var.vpc.internal_allow_cidrs) : 0
  network_acl_id = module.vpc.database_network_acl_id
  rule_number    = count.index + 1500
  egress         = true
  cidr_block     = var.vpc.internal_allow_cidrs[count.index]
  protocol       = "-1"
  rule_action    = "allow"
  from_port      = 0
  to_port        = 0
}

resource "aws_network_acl_rule" "private_acl_rules_in_for_intra" {
  count          = length(var.vpc.internal_allow_cidrs) * (length(var.vpc.subnet_cidr_blocks.intra) > 0 ? 1 : 0)
  network_acl_id = module.vpc.intra_network_acl_id
  rule_number    = count.index + 1500
  egress         = false
  cidr_block     = var.vpc.internal_allow_cidrs[count.index]
  protocol       = "-1"
  rule_action    = "allow"
  from_port      = 0
  to_port        = 0
}

resource "aws_network_acl_rule" "private_acl_rules_out_for_intra" {
  count          = length(var.vpc.internal_allow_cidrs) * (length(var.vpc.subnet_cidr_blocks.intra) > 0 ? 1 : 0)
  network_acl_id = module.vpc.intra_network_acl_id
  rule_number    = count.index + 1500
  egress         = true
  cidr_block     = var.vpc.internal_allow_cidrs[count.index]
  protocol       = "-1"
  rule_action    = "allow"
  from_port      = 0
  to_port        = 0
}
