##
# (c) 2021-2026
#     Cloud Ops Works LLC - https://cloudops.works/
#     Find us on:
#       GitHub: https://github.com/cloudopsworks
#       WebSite: https://cloudops.works
#     Distributed Under Apache v2.0 License
#

variable "vpc" {
  description = "VPC configuration"
  type = object({
    cidr_block          = string               # (Required) CIDR block for the VPC, e.g. "10.0.0.0/16"
    availability_zones  = list(string)         # (Required) List of AZ names, e.g. ["us-east-1a","us-east-1b"]
    public_ip_on_launch = optional(bool, true) # (Optional) Map a public IP to instances launched in public subnets, default: true

    subnet_cidr_blocks = optional(object({
      public   = optional(list(string), []) # (Optional) Public subnet CIDR blocks
      private  = optional(list(string), []) # (Optional) Private subnet CIDR blocks
      database = optional(list(string), []) # (Optional) Database subnet CIDR blocks
      intra    = optional(list(string), []) # (Optional) Intra (isolated, no internet) subnet CIDR blocks
    }), {})

    subnet_names = optional(object({
      public   = optional(list(string), []) # (Optional) Names for public subnets, positionally matched to subnet_cidr_blocks.public
      private  = optional(list(string), []) # (Optional) Names for private subnets
      database = optional(list(string), []) # (Optional) Names for database subnets
    }), {})

    dhcp_option = optional(object({
      dns = optional(list(string), []) # (Optional) DNS server IP addresses for DHCP options set
      domain = optional(object({
        name = optional(string, "sample.com") # (Optional) Domain name suffix for DHCP options, default: "sample.com"
      }), {})
    }), {})

    nat_gateway = optional(object({
      enabled   = optional(bool, true)       # (Optional) Create NAT gateway(s), default: true
      single    = optional(bool, true)       # (Optional) Deploy a single NAT gateway shared across all AZs, default: true
      reuse_eip = optional(bool, false)      # (Optional) Reuse pre-allocated Elastic IPs instead of creating new ones, default: false
      eip_ids   = optional(list(string), []) # (Optional) Existing EIP allocation IDs to use when reuse_eip=true
    }), {})

    nat_instance = optional(object({
      enabled       = optional(bool, false)         # (Optional) Use a NAT instance instead of NAT gateway (overrides nat_gateway), default: false
      size          = optional(string, "t4g.micro") # (Optional) EC2 instance type for the NAT instance, default: "t4g.micro"
      allowed_cidrs = optional(list(string), [])    # (Optional) CIDR blocks allowed to route through the NAT instance
      spot          = optional(bool, false)         # (Optional) Use a Spot instance for the NAT instance, default: false
      high_volume   = optional(bool, false)         # (Optional) Deploy the high-throughput alternat solution, default: false
    }), {})

    flow_logs = optional(object({
      type      = optional(string, "REJECT") # (Optional) Traffic to capture: ACCEPT, REJECT, or ALL, default: "REJECT"
      retention = optional(number, 30)       # (Optional) CloudWatch log group retention period in days, default: 30
    }), {})

    vpn_gateway = optional(object({
      enabled = optional(bool, false) # (Optional) Attach a Virtual Private Gateway to the VPC, default: false
    }), {})

    route_tables = optional(object({
      multiple_intra  = optional(bool, false) # (Optional) Create one route table per intra subnet instead of sharing, default: false
      multiple_public = optional(bool, false) # (Optional) Create one route table per public subnet instead of sharing, default: false
      intra_nat       = optional(bool, false) # (Optional) Route intra subnet egress through the NAT gateway, default: false
    }), {})

    internal_allow_cidrs = optional(list(string), []) # (Optional) CIDR blocks granted unrestricted access via network ACLs and the SSH security group

    default_endpoint = optional(object({
      enabled = optional(bool, true) # (Optional) Create the default S3 Gateway VPC endpoint, default: true
    }), {})

    secrets_manager = optional(object({
      enabled = optional(bool, false) # (Optional) Store bastion SSH keys in AWS Secrets Manager, default: false
    }), {})

    acl_rules = optional(object({
      public = optional(list(object({
        cidr_block  = string
        from_port   = optional(number, 0)
        to_port     = optional(number, 0)
        protocol    = string
        rule_action = string
      })), []) # (Optional) Extra inbound network ACL rules for public subnets (rule numbers start at 1000)
      public_outbound = optional(list(object({
        cidr_block  = string
        from_port   = optional(number, 0)
        to_port     = optional(number, 0)
        protocol    = string
        rule_action = string
      })), []) # (Optional) Extra outbound network ACL rules for public subnets (rule numbers start at 1000)
      private = optional(list(object({
        cidr_block  = string
        from_port   = optional(number, 0)
        to_port     = optional(number, 0)
        protocol    = string
        rule_action = string
      })), []) # (Optional) Extra inbound network ACL rules for private subnets (rule numbers start at 1000)
    }), {})
  })

  validation {
    condition     = contains(["ACCEPT", "REJECT", "ALL"], try(var.vpc.flow_logs.type, "REJECT"))
    error_message = "vpc.flow_logs.type must be one of ACCEPT, REJECT, or ALL."
  }
}

variable "vpn_accesses" {
  description = "CIDR blocks permitted for VPN/external SSH access to the bastion and public network ACLs"
  type        = list(string)
  default     = []
}

variable "endpoint_services" {
  description = "Additional VPC endpoint services to create beyond the default S3 gateway endpoint"
  type        = any
  default     = []
}
