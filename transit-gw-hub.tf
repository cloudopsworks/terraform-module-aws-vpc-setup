##
# (c) 2024 - Cloud Ops Works LLC - https://cloudops.works/
#            On GitHub: https://github.com/cloudopsworks
#            Distributed Under Apache v2.0 License
#
locals {
  hubs = var.transit_gateway.enabled && var.is_hub ? {
    hub000 = {
      vpc_id                                          = module.vpc.vpc_id
      subnet_ids                                      = module.vpc.private_subnets
      dns_support                                     = true
      transit_gateway_default_route_table_association = false
      transit_gateway_default_route_table_propagation = false
      tgw_routes                                      = var.transit_gateway.routes
    }
  } : {}
  spokes = {}
  vpcs   = merge(local.hubs, local.spokes)
}

module "transit_gateway" {
  count           = var.transit_gateway.enabled ? 1 : 0
  source          = "terraform-aws-modules/transit-gateway/aws"
  version         = "~> 2.10"
  name            = "tgw-${local.system_name}"
  description     = "Transit Gateway for Hub ${var.spoke_def}"
  create_tgw      = var.is_hub
  share_tgw       = !var.is_hub
  vpc_attachments = local.vpcs
  tags            = var.extra_tags
}
