##
# (c) 2024 - Cloud Ops Works LLC - https://cloudops.works/
#            On GitHub: https://github.com/cloudopsworks
#            Distributed Under Apache v2.0 License
#
locals {
  hubs = var.transit_gateway.enabled && var.is_hub ? {
    hub000 = {
      vpc_id                                          = module.vpc.vpc_id
      subnet_ids                                      = coalescelist(module.vpc.public_subnets,module.vpc.private_subnets, module.vpc.database_subnets)
      dns_support                                     = true
      transit_gateway_default_route_table_association = true
      transit_gateway_default_route_table_propagation = true
      tgw_routes                                      = var.transit_gateway.routes
    }
  } : {}
  spokes = var.transit_gateway.enabled && !var.is_hub ? {
    #     hub000 = {
    #       tgw_id                                          = var.shared_transit_gateway.transit_gateway_id
    #       vpc_id                                          = var.shared_transit_gateway.vpc_id
    #       subnet_ids                                      = var.shared_transit_gateway.private_subnets
    #       dns_support                                     = true
    #       transit_gateway_default_route_table_association = false
    #       transit_gateway_default_route_table_propagation = false
    #       tgw_destination_cidr                            = var.shared_transit_gateway.destination_cidr
    #       vpc_route_table_ids                             = var.shared_transit_gateway.vpc_route_table_ids
    #       tgw_routes                                      = var.transit_gateway.routes
    #     }
    "spoke${var.spoke_def}" = {
      tgw_id                                          = var.shared_transit_gateway.transit_gateway_id
      vpc_id                                          = module.vpc.vpc_id
      subnet_ids                                      = coalescelist(module.vpc.private_subnets, module.vpc.database_subnets)
      dns_support                                     = true
      transit_gateway_default_route_table_association = true
      transit_gateway_default_route_table_propagation = true
      tgw_destination_cidr                            = var.shared_transit_gateway.destination_cidr
      vpc_route_table_ids                             = module.vpc.private_route_table_ids
      tgw_routes                                      = var.transit_gateway.routes
    }
  } : {}
  vpcs = merge(local.hubs, local.spokes)
}

module "transit_gateway" {
  providers = {
    aws = aws.default
  }
  count                                 = var.transit_gateway.enabled ? 1 : 0
  source                                = "terraform-aws-modules/transit-gateway/aws"
  version                               = "~> 2.10"
  name                                  = "tgw-${local.system_name}"
  description                           = "Transit Gateway for Hub ${var.spoke_def}"
  create_tgw                            = var.is_hub
  share_tgw                             = true # defaults always to share the TGW
  vpc_attachments                       = local.vpcs
  ram_allow_external_principals         = var.transit_gateway.ram.allow_external_principals
  ram_principals                        = var.transit_gateway.ram.principals
  enable_auto_accept_shared_attachments = var.transit_gateway.enable_auto_accept
  ram_resource_share_arn                = var.shared_transit_gateway.ram_share_id
  tags                                  = local.all_tags
}
