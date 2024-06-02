##
# (c) 2024 - Cloud Ops Works LLC - https://cloudops.works/
#            On GitHub: https://github.com/cloudopsworks
#            Distributed Under Apache v2.0 License
#
resource "aws_flow_log" "flow_logs" {
  iam_role_arn    = aws_iam_role.vpc_logs.arn
  log_destination = aws_cloudwatch_log_group.log_group.arn
  traffic_type    = "ALL"
  vpc_id          = module.vpc.vpc_id
}

resource "aws_cloudwatch_log_group" "log_group" {
  name = "spoke-${local.system_name}"
}
