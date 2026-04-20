##
# (c) 2021-2026
#     Cloud Ops Works LLC - https://cloudops.works/
#     Find us on:
#       GitHub: https://github.com/cloudopsworks
#       WebSite: https://cloudops.works
#     Distributed Under Apache v2.0 License
#

# vpc:                                          # (Required) VPC configuration object
#   cidr_block: "10.0.0.0/16"                  # (Required) CIDR block for the VPC
#   availability_zones:                         # (Required) List of AWS availability zone names
#     - "us-east-1a"
#     - "us-east-1b"
#   public_ip_on_launch: true                   # (Optional) Auto-assign public IPs in public subnets. Default: true
#   subnet_cidr_blocks:                         # (Optional) CIDR blocks per subnet tier. Default: all empty
#     public:                                   # (Optional) List of public subnet CIDRs. Default: []
#       - "10.0.1.0/26"
#       - "10.0.1.64/26"
#     private:                                  # (Optional) List of private subnet CIDRs. Default: []
#       - "10.0.8.0/21"
#       - "10.0.16.0/21"
#     database: []                              # (Optional) List of database subnet CIDRs. Default: []
#     intra: []                                 # (Optional) List of intra (no-internet) subnet CIDRs. Default: []
#   subnet_names:                               # (Optional) Friendly names per subnet tier, positional. Default: all empty
#     public: []                                # (Optional) Names for public subnets. Default: []
#     private: []                               # (Optional) Names for private subnets. Default: []
#     database: []                              # (Optional) Names for database subnets. Default: []
#   dhcp_option:                                # (Optional) DHCP options set configuration. Default: {}
#     dns:                                      # (Optional) DNS server IP addresses. Default: []
#       - "10.0.0.2"
#     domain:                                   # (Optional) Domain name configuration. Default: {}
#       name: "example.com"                     # (Optional) Domain name suffix for DHCP. Default: "sample.com"
#   nat_gateway:                                # (Optional) Managed NAT gateway settings. Default: {}
#     enabled: true                             # (Optional) Create NAT gateway(s). Default: true
#     single: true                              # (Optional) Single shared NAT gateway for all AZs. Default: true
#     reuse_eip: false                          # (Optional) Reuse pre-allocated Elastic IPs. Default: false
#     eip_ids: []                               # (Optional) EIP allocation IDs when reuse_eip=true. Default: []
#   nat_instance:                               # (Optional) NAT instance settings (overrides nat_gateway when enabled). Default: {}
#     enabled: false                            # (Optional) Use NAT instance instead of gateway. Default: false
#     size: "t4g.micro"                         # (Optional) Instance type. Values: any EC2 type, arm64 recommended. Default: "t4g.micro"
#     allowed_cidrs: []                         # (Optional) CIDRs allowed to route through the NAT instance. Default: []
#     spot: false                               # (Optional) Use a Spot instance for cost savings. Default: false
#     high_volume: false                        # (Optional) Deploy high-throughput alternat solution. Default: false
#   flow_logs:                                  # (Optional) VPC Flow Logs configuration. Default: {}
#     type: "REJECT"                            # (Optional) Traffic to capture. Values: ACCEPT, REJECT, ALL. Default: "REJECT"
#     retention: 30                             # (Optional) CloudWatch log group retention in days. Default: 30
#   vpn_gateway:                                # (Optional) Virtual Private Gateway settings. Default: {}
#     enabled: false                            # (Optional) Attach a VGW to the VPC. Default: false
#   route_tables:                               # (Optional) Route table behaviour flags. Default: {}
#     multiple_intra: false                     # (Optional) One route table per intra subnet. Default: false
#     multiple_public: false                    # (Optional) One route table per public subnet. Default: false
#     intra_nat: false                          # (Optional) Route intra subnet egress via NAT. Default: false
#   internal_allow_cidrs: []                    # (Optional) CIDRs allowed unrestricted access via ACLs and SSH SG. Default: []
#   default_endpoint:                           # (Optional) Default S3 Gateway endpoint. Default: {}
#     enabled: true                             # (Optional) Create the default S3 Gateway VPC endpoint. Default: true
#   secrets_manager:                            # (Optional) Secrets Manager integration for bastion keys. Default: {}
#     enabled: false                            # (Optional) Store bastion SSH keys in Secrets Manager. Default: false
#   acl_rules:                                  # (Optional) Extra network ACL rules appended per tier (rule numbers start at 1000). Default: {}
#     public: []                                # (Optional) Extra inbound rules for public subnets. Default: []
#     #  - cidr_block: "203.0.113.10/32"        #   cidr_block: (Required) Target CIDR
#     #    from_port: 22                         #   from_port: (Optional) Start of port range. Default: 0
#     #    to_port: 22                           #   to_port: (Optional) End of port range. Default: 0
#     #    protocol: "tcp"                       #   protocol: (Required) IP protocol. Values: tcp, udp, icmp, -1 (all)
#     #    rule_action: "allow"                  #   rule_action: (Required) Values: allow, deny
#     public_outbound: []                       # (Optional) Extra outbound rules for public subnets. Default: []
#     private: []                               # (Optional) Extra inbound rules for private subnets. Default: []
variable "vpc" {
  description = "VPC configuration. Required: cidr_block, availability_zones. All other attributes are optional with safe defaults."
  type = object({
    cidr_block          = string               # (Required) CIDR block for the VPC, e.g. "10.0.0.0/16"
    availability_zones  = list(string)         # (Required) AWS AZ names, e.g. ["us-east-1a", "us-east-1b"]
    public_ip_on_launch = optional(bool, true) # (Optional) Auto-assign public IPs in public subnets. Default: true

    subnet_cidr_blocks = optional(object({
      public   = optional(list(string), []) # (Optional) Public subnet CIDRs. Default: []
      private  = optional(list(string), []) # (Optional) Private subnet CIDRs. Default: []
      database = optional(list(string), []) # (Optional) Database subnet CIDRs (also creates a DB subnet group). Default: []
      intra    = optional(list(string), []) # (Optional) Intra subnet CIDRs (no internet route). Default: []
    }), {})

    subnet_names = optional(object({
      public   = optional(list(string), []) # (Optional) Names for public subnets, positionally matched. Default: []
      private  = optional(list(string), []) # (Optional) Names for private subnets, positionally matched. Default: []
      database = optional(list(string), []) # (Optional) Names for database subnets, positionally matched. Default: []
    }), {})

    dhcp_option = optional(object({
      dns = optional(list(string), []) # (Optional) DNS server IPs for the VPC DHCP options set. Default: []
      domain = optional(object({
        name = optional(string, "sample.com") # (Optional) Domain name suffix for DHCP options. Default: "sample.com"
      }), {})
    }), {})

    nat_gateway = optional(object({
      enabled   = optional(bool, true)       # (Optional) Create NAT gateway(s). Default: true
      single    = optional(bool, true)       # (Optional) Single NAT gateway shared across all AZs. Default: true
      reuse_eip = optional(bool, false)      # (Optional) Reuse pre-allocated Elastic IPs. Default: false
      eip_ids   = optional(list(string), []) # (Optional) EIP allocation IDs to reuse when reuse_eip=true. Default: []
    }), {})

    nat_instance = optional(object({
      enabled       = optional(bool, false)         # (Optional) Use fck-nat instance instead of gateway (overrides nat_gateway). Default: false
      size          = optional(string, "t4g.micro") # (Optional) EC2 instance type. arm64 types recommended. Default: "t4g.micro"
      allowed_cidrs = optional(list(string), [])    # (Optional) CIDRs routed through the NAT instance. Default: []
      spot          = optional(bool, false)         # (Optional) Use a Spot instance for cost savings. Default: false
      high_volume   = optional(bool, false)         # (Optional) Deploy the high-throughput alternat solution. Default: false
    }), {})

    flow_logs = optional(object({
      type      = optional(string, "REJECT") # (Optional) Traffic to capture. Values: ACCEPT, REJECT, ALL. Default: "REJECT"
      retention = optional(number, 30)       # (Optional) CloudWatch log group retention in days. Default: 30
    }), {})

    vpn_gateway = optional(object({
      enabled = optional(bool, false) # (Optional) Attach a Virtual Private Gateway to the VPC. Default: false
    }), {})

    route_tables = optional(object({
      multiple_intra  = optional(bool, false) # (Optional) Create one route table per intra subnet instead of sharing. Default: false
      multiple_public = optional(bool, false) # (Optional) Create one route table per public subnet instead of sharing. Default: false
      intra_nat       = optional(bool, false) # (Optional) Route intra subnet egress through the NAT gateway. Default: false
    }), {})

    internal_allow_cidrs = optional(list(string), []) # (Optional) CIDRs granted unrestricted access via network ACLs and SSH security group. Default: []

    default_endpoint = optional(object({
      enabled = optional(bool, true) # (Optional) Create the default S3 Gateway VPC endpoint. Default: true
    }), {})

    secrets_manager = optional(object({
      enabled = optional(bool, false) # (Optional) Store bastion SSH keypair in AWS Secrets Manager. Default: false
    }), {})

    acl_rules = optional(object({
      public = optional(list(object({
        cidr_block  = string              # (Required) Target CIDR block
        from_port   = optional(number, 0) # (Optional) Start of port range. Default: 0
        to_port     = optional(number, 0) # (Optional) End of port range. Default: 0
        protocol    = string              # (Required) IP protocol: tcp, udp, icmp, or -1 (all)
        rule_action = string              # (Required) ACL action. Values: allow, deny
      })), [])                            # (Optional) Extra inbound ACL rules for public subnets (rule numbers start at 1000). Default: []
      public_outbound = optional(list(object({
        cidr_block  = string
        from_port   = optional(number, 0)
        to_port     = optional(number, 0)
        protocol    = string
        rule_action = string
      })), []) # (Optional) Extra outbound ACL rules for public subnets (rule numbers start at 1000). Default: []
      private = optional(list(object({
        cidr_block  = string
        from_port   = optional(number, 0)
        to_port     = optional(number, 0)
        protocol    = string
        rule_action = string
      })), []) # (Optional) Extra inbound ACL rules for private subnets (rule numbers start at 1000). Default: []
    }), {})
  })

  validation {
    condition     = contains(["ACCEPT", "REJECT", "ALL"], try(var.vpc.flow_logs.type, "REJECT"))
    error_message = "vpc.flow_logs.type must be one of ACCEPT, REJECT, or ALL."
  }
}

# vpn_accesses:        # (Optional) CIDR blocks for VPN/external SSH access to bastion and public ACLs. Default: []
# #  - "203.0.113.10/32"
variable "vpn_accesses" {
  description = "CIDR blocks permitted for VPN/external SSH access to the bastion and public network ACLs. Default: []"
  type        = list(string)
  default     = []
}

# endpoint_services:   # (Optional) Additional VPC endpoint services beyond the default S3 gateway. Default: []
# #  - name: ssm
# #  - name: ssmmessages
# #  - name: ec2messages
# #  - name: dynamodb
# #    type: Gateway    # (Optional) Endpoint type. Values: Interface, Gateway. Default: Interface
# #    policy: true     # (Optional) Attach a deny-external-traffic policy. Default: false
variable "endpoint_services" {
  description = "Additional VPC endpoint services to create beyond the default S3 gateway endpoint. Default: []"
  type        = any
  default     = []
}
