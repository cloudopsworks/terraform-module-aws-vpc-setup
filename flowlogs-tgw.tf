##
# (c) 2024 - Cloud Ops Works LLC - https://cloudops.works/
#            On GitHub: https://github.com/cloudopsworks
#            Distributed Under Apache v2.0 License
#
resource "aws_flow_log" "tgw_flow_logs" {
  count              = var.transit_gateway.enabled ? 1 : 0
  iam_role_arn       = aws_iam_role.vpc_logs.arn
  log_destination    = aws_cloudwatch_log_group.tgw_log_group[0].arn
  traffic_type       = var.flow_logs_type
  transit_gateway_id = module.transit_gateway[0].ec2_transit_gateway_id
}

resource "aws_cloudwatch_log_group" "tgw_log_group" {
  count = var.transit_gateway.enabled ? 1 : 0
  name  = "network/${local.flowlogs_prefix}/${var.spoke_def}/tgw-${local.system_name}"
}

# TGW Attachment
resource "aws_flow_log" "tgw_att_flow_logs" {
  count                         = var.transit_gateway.enabled ? 1 : 0
  iam_role_arn                  = aws_iam_role.vpc_logs.arn
  log_destination               = aws_cloudwatch_log_group.tgw_att_log_group[0].arn
  traffic_type                  = var.flow_logs_type
  transit_gateway_attachment_id = module.transit_gateway[0].ec2_transit_gateway_vpc_attachment.id
}

resource "aws_cloudwatch_log_group" "tgw_att_log_group" {
  count = var.transit_gateway.enabled ? 1 : 0
  name  = "network/${local.flowlogs_prefix}/${var.spoke_def}/tgw-att-${local.system_name}"
}
