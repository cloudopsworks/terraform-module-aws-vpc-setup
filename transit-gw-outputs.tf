##
# (c) 2024 - Cloud Ops Works LLC - https://cloudops.works/
#            On GitHub: https://github.com/cloudopsworks
#            Distributed Under Apache v2.0 License
#
locals {
  tgw_output = (var.transit_gateway.enabled ? {
    id              = module.transit_gateway[0].ec2_transit_gateway_id
    arn             = module.transit_gateway[0].ec2_transit_gateway_arn
    route_table_id  = module.transit_gateway[0].ec2_transit_gateway_vpc_attachment_ids
    route_ids       = module.transit_gateway[0].ec2_transit_gateway_route_ids
    route_table_ids = module.transit_gateway[0].ec2_transit_gateway_route_table_association_ids
    vpc_attachments = module.transit_gateway[0].ec2_transit_gateway_vpc_attachment_ids
  } : {})
}

output "transit_gateway" {
  value = local.tgw_output
}