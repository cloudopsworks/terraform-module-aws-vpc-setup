##
# (c) 2024 - Cloud Ops Works LLC - https://cloudops.works/
#            On GitHub: https://github.com/cloudopsworks
#            Distributed Under Apache v2.0 License
#

locals {
  default_endpoints = {
    # VPC endpoint for S3
    s3 = {
      service             = "s3"
      service_type        = "Gateway"
      private_dns_enabled = true
      tags = merge(
        { Name = "${local.system_name}-s3-vpc-endpoint" },
        local.all_tags
      )
    }
  }
  custom_endpoints = {
    for e in var.endpoint_services : e.name => {
      service             = e.name
      service_type        = try(e.type, "Interface")
      private_dns_enabled = try(e.private_dns, false)
      policy              = try(e.policy, false) ? data.aws_iam_policy_document.generic_endpoint_policy.json : null
      subnet_ids = try(e.type, "Interface") == "Interface" ? (
        try(e.subnets, "private") == "private" ? module.vpc.private_subnets : module.vpc.intra_subnets
      ) : null
      dns_options = try(e.type, "Interface") == "Interface" ? {
        private_dns_only_for_inbound_resolver_endpoint = try(e.dns_only_for_inbound, null)
      } : {}
      tags = merge(
        { Name = "${local.system_name}-${e.name}-vpc-endpoint" },
        local.all_tags
      )
    }
  }
  endpoints = merge(var.default_endpoint ? local.default_endpoints : {}, local.custom_endpoints)
}

data "aws_iam_policy_document" "generic_endpoint_policy" {
  statement {
    effect    = "Deny"
    actions   = ["*"]
    resources = ["*"]

    principals {
      type        = "*"
      identifiers = ["*"]
    }

    condition {
      test     = "StringNotEquals"
      variable = "aws:SourceVpc"

      values = [module.vpc.vpc_id]
    }
  }
}

module "vpc_endpoints" {
  depends_on = [
    aws_security_group.endpoints,
    module.vpc
  ]
  source  = "terraform-aws-modules/vpc/aws//modules/vpc-endpoints"
  version = "~> 5.0"

  vpc_id             = module.vpc.vpc_id
  security_group_ids = [aws_security_group.endpoints.id]
  endpoints          = local.endpoints
  tags               = local.all_tags
}