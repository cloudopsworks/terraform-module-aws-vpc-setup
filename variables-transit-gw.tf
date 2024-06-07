##
# (c) 2024 - Cloud Ops Works LLC - https://cloudops.works/
#            On GitHub: https://github.com/cloudopsworks
#            Distributed Under Apache v2.0 License
#
variable "transit_gateway" {
  type = object({
    enabled            = bool,
    routes             = list(map(any))
    enable_auto_accept = optional(bool, false)
    ram = optional(object({
      allow_external_principals = optional(bool, false)
      principals                = optional(list(string), [])
    }))
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
    tgw_route_table_id  = string
  })
  default = {
    vpc_id              = null
    transit_gateway_id  = null
    ram_share_id        = null
    private_subnets     = []
    vpc_route_table_ids = []
    destination_cidr    = null
    tgw_route_table_id  = null
  }
}
