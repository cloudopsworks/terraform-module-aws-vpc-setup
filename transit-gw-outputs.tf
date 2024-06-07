##
# (c) 2024 - Cloud Ops Works LLC - https://cloudops.works/
#            On GitHub: https://github.com/cloudopsworks
#            Distributed Under Apache v2.0 License
#
locals {
  tgw_output_hub = (var.transit_gateway.enabled ? {
    id                          = module.transit_gateway[0].ec2_transit_gateway_id
    arn                         = module.transit_gateway[0].ec2_transit_gateway_arn
    vpc_route_table_ids         = module.transit_gateway[0].ec2_transit_gateway_vpc_attachment_ids
    route_ids                   = module.transit_gateway[0].ec2_transit_gateway_route_ids
    route_table_id              = module.transit_gateway[0].ec2_transit_gateway_route_table_id
    route_table_association_ids = module.transit_gateway[0].ec2_transit_gateway_route_table_association_ids
    route_table_association     = module.transit_gateway[0].ec2_transit_gateway_route_table_association
    route_table_propagation     = module.transit_gateway[0].ec2_transit_gateway_route_table_propagation
    vpc_attachments             = module.transit_gateway[0].ec2_transit_gateway_vpc_attachment_ids
    ram_share_id                = module.transit_gateway[0].ram_resource_share_id
    } : {
    id                          = null
    arn                         = null
    vpc_route_table_ids         = null
    route_ids                   = null
    route_table_id              = null
    route_table_association_ids = null
    route_table_association     = null
    route_table_propagation     = null
    vpc_attachments             = null
    ram_share_id                = null
  })
}

output "transit_gateway" {
  value = local.tgw_output_hub
}

output "transit_gateway_settings" {
  value = {
    is_hub     = var.is_hub
    tgw        = var.transit_gateway
    vpcs       = local.vpcs
    shared_tgw = var.shared_transit_gateway
  }
}
