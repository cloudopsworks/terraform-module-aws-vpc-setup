##
# (c) 2024 - Cloud Ops Works LLC - https://cloudops.works/
#            On GitHub: https://github.com/cloudopsworks
#            Distributed Under Apache v2.0 License
#
locals {
  tgw_output_hub = (var.transit_gateway.enabled && var.is_hub ? {
    id              = module.transit_gateway[0].ec2_transit_gateway_id
    arn             = module.transit_gateway[0].ec2_transit_gateway_arn
    route_table_id  = module.transit_gateway[0].ec2_transit_gateway_vpc_attachment_ids
    route_ids       = module.transit_gateway[0].ec2_transit_gateway_route_ids
    route_table_ids = module.transit_gateway[0].ec2_transit_gateway_route_table_association_ids
    vpc_attachments = module.transit_gateway[0].ec2_transit_gateway_vpc_attachment_ids
    ram_share_id    = module.transit_gateway[0].ram_resource_share_id
    } : {
    id              = null
    arn             = null
    route_table_id  = null
    route_ids       = null
    route_table_ids = null
    vpc_attachments = null

  })
  tgw_output_spoke = (var.transit_gateway.enabled && !var.is_hub ? {
    id              = module.transit_gateway[0].ec2_transit_gateway_id
    arn             = module.transit_gateway[0].ec2_transit_gateway_arn
    route_table_id  = module.transit_gateway[0].ec2_transit_gateway_vpc_attachment_ids
    route_ids       = module.transit_gateway[0].ec2_transit_gateway_route_ids
    route_table_ids = module.transit_gateway[0].ec2_transit_gateway_route_table_association_ids
    vpc_attachments = module.transit_gateway[0].ec2_transit_gateway_vpc_attachment_ids
    ram_share_id    = module.transit_gateway[0].ram_resource_share_id
    } : {
    id              = null
    arn             = null
    route_table_id  = null
    route_ids       = null
    route_table_ids = null
    vpc_attachments = null

  })
}

output "hub_transit_gateway" {
  value = local.tgw_output_hub
}

output "spoke_transit_gateway" {
  value = local.tgw_output_spoke
}