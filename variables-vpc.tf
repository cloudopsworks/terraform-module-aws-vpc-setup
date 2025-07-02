##
# (c) 2021-2025
#     Cloud Ops Works LLC - https://cloudops.works/
#     Find us on:
#       GitHub: https://github.com/cloudopsworks
#       WebSite: https://cloudops.works
#     Distributed Under Apache v2.0 License
#

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "availability_zones" {
  description = "List of availability zones for the VPC"
  type        = list(string)
}

variable "public_subnets" {
  description = "A list of public subnets inside the VPC"
  type        = list(any)
}

variable "public_subnets_names" {
  description = "A list of public subnets names inside the VPC"
  type        = list(string)
  default     = []
}

variable "private_subnets" {
  description = "A list of private subnets inside the VPC"
  type        = list(any)
}

variable "private_subnets_names" {
  description = "A list of private subnets names inside the VPC"
  type        = list(string)
  default     = []
}

# variable "forward_vpc_id" {
#   type = string
# }

variable "dhcp_dns" {
  description = "A list of DNS servers to use for DHCP options in the VPC"
  type        = list(string)
}

variable "dhcp_domain_name" {
  description = "The domain name to use for DHCP options in the VPC"
  type        = string
  default     = "sample.com"
}

variable "database_subnets" {
  description = "A list of database subnets inside the VPC"
  type        = list(string)
}

variable "database_subnets_names" {
  description = "A list of database subnets names inside the VPC"
  type        = list(string)
  default     = []
}

variable "intra_subnets" {
  description = "A list of intra subnets inside the VPC"
  type        = list(string)
  default     = []
}

variable "multiple_intra_route_tables" {
  description = "Flag to create multiple intra route tables, if true, it will create a route table for each intra subnet"
  type        = bool
  default     = false
}

variable "multiple_public_route_tables" {
  description = "Flag to create multiple public route tables, if true, it will create a route table for each public subnet"
  type        = bool
  default     = false
}

variable "create_bastion" {
  description = "Flag to create a bastion host in the VPC"
  type        = bool
}

# variable "forward_route_cidrs" {
#   type = list(string)
# }

variable "vpn_accesses" {
  description = "List of CIDR blocks for VPN access, external access, or other network access"
  type        = list(string)
  default     = []
}

variable "docker_version_server" {
  description = "Docker version to use for the server, at bastion host"
  type        = string
  default     = "18.09"
}

variable "extra_tags" {
  description = "Additional tags to apply to the VPC and its resources"
  type        = map(string)
  default     = {}
}

variable "flow_logs_type" {
  description = "Type of flow logs to create. Options are ACCEPT, REJECT, or ALL. Default is REJECT."
  type        = string
  default     = "REJECT"
  validation {
    condition     = contains(["ACCEPT", "REJECT", "ALL"], var.flow_logs_type)
    error_message = "Invalid value for flow_logs_type. Must be one of ACCEPT, REJECT, or ALL"
  }
}

variable "single_nat_gateway" {
  description = "Flag to create a single NAT gateway for the VPC. If true, only one NAT gateway will be created, otherwise one per public subnet."
  type        = bool
  default     = true
}

variable "intra_route_nat_gateway" {
  description = "Flag to use NAT gateway for intra route tables. If true, the NAT gateway will be used for intra route tables."
  type        = bool
  default     = false
}

variable "enable_nat_gateway" {
  description = "Flag to enable NAT gateway creation. If true, a NAT gateway will be created in the VPC."
  type        = bool
  default     = true
}

variable "reuse_nat_ips" {
  description = "Flag to reuse existing NAT IPs. If true, it will use existing NAT IPs instead of creating new ones."
  type        = bool
  default     = false
}

variable "external_nat_ip_ids" {
  description = "List of external NAT IP IDs to use if reuse_nat_ips is true. This is used to specify existing NAT IPs to reuse."
  type        = list(string)
  default     = []
}

variable "private_acl_rules" {
  description = "List of inbound rules for the private network ACL"
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
  description = "List of outbound rules for the public network ACL"
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
  description = "List of inbound rules for the public network ACL"
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
  description = "List of CIDR blocks to allow internal traffic within the VPC. This is used to define which CIDRs can communicate with each other."
  type        = list(string)
  default     = []
}

variable "endpoint_services" {
  description = "List of endpoint services to create in the VPC. This is used to define which AWS services will have endpoints in the VPC."
  type        = any
  default     = []
}

variable "default_endpoint" {
  description = "Default endpoint for the VPC. This is used to specify the default endpoint for the VPC."
  type        = bool
  default     = true
}

variable "secrets_manager_enabled" {
  description = "Flag to enable AWS Secrets Manager for the VPC. If true, AWS Secrets Manager will be enabled for the VPC."
  type        = bool
  default     = false
}

variable "logs_retention" {
  description = "CloudWatch Logs retention in days"
  type        = number
  default     = 30
}

variable "enable_vpn_gateway" {
  description = "Flag to enable VPN gateway creation. If true, a VPN gateway will be created in the VPC."
  type        = bool
  default     = false
}
