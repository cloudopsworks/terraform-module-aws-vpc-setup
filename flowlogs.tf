##
# (c) 2024 - Cloud Ops Works LLC - https://cloudops.works/
#            On GitHub: https://github.com/cloudopsworks
#            Distributed Under Apache v2.0 License
#
locals {
  flowlogs_prefix = var.is_hub ? "hub" : "spoke"
}

resource "aws_flow_log" "flow_logs" {
  iam_role_arn    = aws_iam_role.vpc_logs.arn
  log_destination = aws_cloudwatch_log_group.log_group.arn
  traffic_type    = var.flow_logs_type
  vpc_id          = module.vpc.vpc_id

  tags = merge(
    local.all_tags,
    {
      Name = "vpc-${local.system_name}-flowlogs"
    }
  )
}

resource "aws_cloudwatch_log_group" "log_group" {
  name = "network/${local.flowlogs_prefix}/${var.spoke_def}/vpc-${local.system_name}"
}


