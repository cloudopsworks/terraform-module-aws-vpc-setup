##
# (c) 2024 - Cloud Ops Works LLC - https://cloudops.works/
#            On GitHub: https://github.com/cloudopsworks
#            Distributed Under Apache v2.0 License
#
variable "spoke_def" {
  type    = string
  default = "001"
}

variable "org" {
  type = object({
    organization_name = string
    organization_unit = string
    environment_type  = string
    environment_name  = string
  })
}

variable "vpc_cidr" {
  type = string
}

variable "availability_zones" {
  type = list(string)
}

variable "public_subnets" {
  type = list(any)
}

variable "public_subnets_names" {
  type    = list(string)
  default = []
}

variable "private_subnets" {
  type = list(any)
}

variable "private_subnets_names" {
  type    = list(string)
  default = []
}

# variable "forward_vpc_id" {
#   type = string
# }

variable "dhcp_dns" {
  type = list(string)
}

variable "database_subnets" {
  type = list(string)
}

variable "database_subnets_names" {
  type    = list(string)
  default = []
}

variable "create_bastion" {
  type = bool
}

# variable "forward_route_cidrs" {
#   type = list(string)
# }

variable "vpn_accesses" {
  type    = list(string)
  default = []
}

variable "docker_version_server" {
  type    = string
  default = "18.09"
}

variable "extra_tags" {
  type    = map(string)
  default = {}
}