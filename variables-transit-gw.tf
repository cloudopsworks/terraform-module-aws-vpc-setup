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

variable "transit_gateway_ram_share_id" {
  type    = string
  default = null
}