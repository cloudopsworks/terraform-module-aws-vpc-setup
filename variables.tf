##
# (c) 2024 - Cloud Ops Works LLC - https://cloudops.works/
#            On GitHub: https://github.com/cloudopsworks
#            Distributed Under Apache v2.0 License
#

# Establish this is a HUB or spoke configuration
variable "is_hub" {
  type    = bool
  default = false
}

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

variable "dhcp_domain_name" {
  type    = string
  default = "sample.com"
}

variable "database_subnets" {
  type = list(string)
}

variable "database_subnets_names" {
  type    = list(string)
  default = []
}

variable "intra_subnets" {
  description = "A list of intra subnets inside the VPC"
  type        = list(string)
  default     = []
}

variable "multiple_intra_route_tables" {
  type    = bool
  default = false
}

variable "multiple_public_route_tables" {
  type    = bool
  default = false
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

variable "flow_logs_type" {
  type    = string
  default = "REJECT"
  validation {
    condition     = contains(["ACCEPT", "REJECT", "ALL"], var.flow_logs_type)
    error_message = "Invalid value for flow_logs_type. Must be one of ACCEPT, REJECT, or ALL"
  }
}

variable "single_nat_gateway" {
  type    = bool
  default = true
}

variable "enable_nat_gateway" {
  type    = bool
  default = true
}

variable "reuse_nat_ips" {
  type    = bool
  default = false
}

variable "external_nat_ip_ids" {
  type    = list(string)
  default = []
}

variable "private_acl_rules" {
  type = list(object({
    cidr_block  = string,
    from_port   = optional(number, 0),
    to_port     = optional(number, 0),
    protocol    = string,
    rule_action = string,
  }))
  default = []
}

variable "public_outbound_rules" {
  type = list(object({
    cidr_block  = string,
    from_port   = optional(number, 0),
    to_port     = optional(number, 0),
    protocol    = string,
    rule_action = string,
  }))
  default = []
}

variable "public_acl_rules" {
  type = list(object({
    cidr_block  = string,
    from_port   = optional(number, 0),
    to_port     = optional(number, 0),
    protocol    = string,
    rule_action = string,
  }))
  default = []
}

variable "internal_allow_cidrs" {
  type    = list(string)
  default = []
}

variable "endpoint_services" {
  type = list(object({
    name                 = string
    type                 = optional(string, "Interface")
    private_dns          = optional(bool, true)
    policy               = optional(bool, false)
    dns_only_for_inbound = optional(bool, false)
  }))
  default = []
}

variable "default_endpoint" {
  type    = bool
  default = true
}

variable "secrets_manager_enabled" {
  type    = bool
  default = false
}