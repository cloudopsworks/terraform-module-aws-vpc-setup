##
# (c) 2024 - Cloud Ops Works LLC - https://cloudops.works/
#            On GitHub: https://github.com/cloudopsworks
#            Distributed Under Apache v2.0 License
#
variable "transit_gateway" {
  type = object({
    enabled = bool
    routes  = list(map(any))
  })
}

variable "shared_transit_gateway" {
  type = object({
    vpc_id              = string
    transit_gateway_id  = string
    ram_share_id        = string
    private_subnets     = list(string)
    vpc_route_table_ids = list(string)
    destination_cidr    = string
  })
  default = {
    vpc_id              = null
    transit_gateway_id  = null
    ram_share_id        = null
    private_subnets     = []
    vpc_route_table_ids = []
    destination_cidr    = null
  }
}
