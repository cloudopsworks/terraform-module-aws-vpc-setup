##
# (c) 2024 - Cloud Ops Works LLC - https://cloudops.works/
#            On GitHub: https://github.com/cloudopsworks
#            Distributed Under Apache v2.0 License
#
locals {
  acl_private_default = [
    { # Allow all unrestricted inbound traffic for VPC network
      "cidr_block"  = var.vpc_cidr
      "from_port"   = 0
      "to_port"     = 0
      "protocol"    = "-1"
      "rule_action" = "allow"
      "rule_number" : 100
    },
    { # Allow Backport binding TCP Except RDP < 3389
      "cidr_block"  = "0.0.0.0/0"
      "from_port"   = 1024
      "to_port"     = 3388
      "protocol"    = "tcp"
      "rule_action" = "allow"
      "rule_number" : 200
    },
    { # Allow Backport binding TCP Except RDP > 3389
      "cidr_block"  = "0.0.0.0/0"
      "from_port"   = 3390
      "to_port"     = 65535
      "protocol"    = "tcp"
      "rule_action" = "allow"
      "rule_number" : 201
    },
    { # Allow Backport binding UDP Except RDP < 3389
      "cidr_block"  = "0.0.0.0/0"
      "from_port"   = 1024
      "to_port"     = 3388
      "protocol"    = "udp"
      "rule_action" = "allow"
      "rule_number" : 300
    },
    { # Allow Backport binding UDP Except RDP > 3389
      "cidr_block"  = "0.0.0.0/0"
      "from_port"   = 3390
      "to_port"     = 65535
      "protocol"    = "udp"
      "rule_action" = "allow"
      "rule_number" : 301
    }
  ]
  private_outbound_acl_rules_default = [
    { # Allow all unrestricted outbound traffic for VPC network
      "cidr_block"  = var.vpc_cidr
      "from_port"   = 0
      "to_port"     = 0
      "protocol"    = "-1"
      "rule_action" = "allow"
      "rule_number" : 100
    },
    { # Allow binding TCP for service that specify "Foreign Address" = 0.0.0.0:*
      "cidr_block"  = "0.0.0.0/0"
      "from_port"   = 0
      "to_port"     = 65535
      "protocol"    = "tcp"
      "rule_action" = "allow"
      "rule_number" : 200
    },
    { # Allow binding UDP for service that specify "Foreign Address" = 0.0.0.0:*
      "cidr_block"  = "0.0.0.0/0"
      "from_port"   = 0
      "to_port"     = 65535
      "protocol"    = "udp"
      "rule_action" = "allow"
      "rule_number" : 300
    }
  ]
  acl_public_vpn = concat([for access in var.vpn_accesses :
    { # Allow SSH Access for bastion hosts
      cidr_block  = access,
      from_port   = 22,
      to_port     = 22,
      protocol    = "tcp",
      rule_action = "allow",
      rule_number = 400 + index(var.vpn_accesses, access)
    }
    ],
    [for access in var.vpn_accesses :
      { # Allow SSH Access for bastion hosts
        cidr_block  = access,
        from_port   = 3389,
        to_port     = 3389,
        protocol    = "tcp",
        rule_action = "allow",
        rule_number = 450 + index(var.vpn_accesses, access)
      }
  ])
  acl_public_default = [
    { # Allow all from internal network Instances behind NAT will be permitted to go out
      "cidr_block"  = var.vpc_cidr
      "from_port"   = 0
      "to_port"     = 0
      "protocol"    = "-1"
      "rule_action" = "allow"
      "rule_number" : 100
    },
    { # Allow HTTP Access
      "cidr_block"  = "0.0.0.0/0"
      "from_port"   = 80
      "to_port"     = 80
      "protocol"    = "tcp"
      "rule_action" = "allow"
      "rule_number" : 200
    },
    { # Allow HTTPS Access
      "cidr_block"  = "0.0.0.0/0"
      "from_port"   = 443
      "to_port"     = 443
      "protocol"    = "tcp"
      "rule_action" = "allow"
      "rule_number" : 300
    },
    { # Allow Backport binding TCP except RDP < 3389
      "cidr_block"  = "0.0.0.0/0"
      "from_port"   = 1024
      "to_port"     = 3388
      "protocol"    = "tcp"
      "rule_action" = "allow"
      "rule_number" : 500
    },
    { # Allow Backport binding TCP except RDP > 3389
      "cidr_block"  = "0.0.0.0/0"
      "from_port"   = 3390
      "to_port"     = 65535
      "protocol"    = "tcp"
      "rule_action" = "allow"
      "rule_number" : 501
    },
    { # Allow access to SMTP, specially if there are instances behind NAT
      "cidr_block"  = "0.0.0.0/0"
      "from_port"   = 465
      "to_port"     = 465
      "protocol"    = "tcp"
      "rule_action" = "allow"
      "rule_number" : 600
    },
    { # Allow access to SMTP, specially if there are instances behind NAT
      "cidr_block"  = "0.0.0.0/0"
      "from_port"   = 25
      "to_port"     = 25
      "protocol"    = "tcp"
      "rule_action" = "allow"
      "rule_number" : 700
    },
    { # Allow access to SMTP, specially if there are instances behind NAT
      "cidr_block"  = "0.0.0.0/0"
      "from_port"   = 587
      "to_port"     = 587
      "protocol"    = "tcp"
      "rule_action" = "allow"
      "rule_number" : 800
    }
    # ,
    # { # Allow Backport binding UDP
    #   "cidr_block": "0.0.0.0/0",
    #   "from_port": 1025,
    #   "to_port": 65535,
    #   "protocol": "udp",
    #   "rule_action": "allow",
    #   "rule_number": 1300
    # }
  ]
  acl_public_outbound_default = [
    { # Allow unrestricted Outbound traffic to VPC internal addresses
      "cidr_block"  = var.vpc_cidr
      "from_port"   = 0
      "to_port"     = 0
      "protocol"    = "-1"
      "rule_action" = "allow"
      "rule_number" : 100
    },
    { # Allow Outbound traffic for ephemeral ports (NAT+NLB/ALB)
      "cidr_block"  = "0.0.0.0/0"
      "from_port"   = 1024
      "to_port"     = 65535
      "protocol"    = "tcp"
      "rule_action" = "allow"
      "rule_number" : 200
    },
    { # Allow Outbound traffic for HTTP (NAT)
      "cidr_block"  = "0.0.0.0/0"
      "from_port"   = 80
      "to_port"     = 80
      "protocol"    = "tcp"
      "rule_action" = "allow"
      "rule_number" : 300
    },
    { # Allow Outbound traffic for HTTPS (NAT)
      "cidr_block" : "0.0.0.0/0",
      "from_port" : 443,
      "to_port" : 443,
      "protocol" : "tcp",
      "rule_action" : "allow",
      "rule_number" : 400
    },
    { # Allow Outbound traffic for SMTPS (NAT)
      "cidr_block" : "0.0.0.0/0",
      "from_port" : 465,
      "to_port" : 465,
      "protocol" : "tcp",
      "rule_action" : "allow",
      "rule_number" : 500
    },
    { # Allow Outbound traffic for SMTP (NAT)
      "cidr_block" : "0.0.0.0/0",
      "from_port" : 25,
      "to_port" : 25,
      "protocol" : "tcp",
      "rule_action" : "allow",
      "rule_number" : 600
    },
    { # Allow Outbound traffic for SMTPS (NAT)
      "cidr_block" : "0.0.0.0/0",
      "from_port" : 587,
      "to_port" : 587,
      "protocol" : "tcp",
      "rule_action" : "allow",
      "rule_number" : 700
    },
    { # Allow Outbound traffic for DNS (NAT)
      "cidr_block" : "0.0.0.0/0",
      "from_port" : 53,
      "to_port" : 53,
      "protocol" : "tcp",
      "rule_action" : "allow",
      "rule_number" : 800
    },
    { # Allow Outbound traffic for DNS (NAT)
      "cidr_block" : "0.0.0.0/0",
      "from_port" : 53,
      "to_port" : 53,
      "protocol" : "udp",
      "rule_action" : "allow",
      "rule_number" : 900
    }
  ]
  acl_private          = local.acl_private_default
  acl_private_outbound = local.private_outbound_acl_rules_default
  acl_public           = concat(local.acl_public_default, local.acl_public_vpn)
  acl_public_outbound  = local.acl_public_outbound_default
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0"

  name                                = "vpc-${local.system_name}"
  cidr                                = var.vpc_cidr
  azs                                 = var.availability_zones
  private_subnets                     = var.private_subnets
  private_subnet_names                = var.private_subnets_names
  public_subnets                      = var.public_subnets
  public_subnet_names                 = var.public_subnets_names
  database_subnets                    = var.database_subnets
  database_subnet_names               = var.database_subnets_names
  intra_subnets                       = var.intra_subnets
  create_multiple_intra_route_tables  = var.multiple_intra_route_tables
  create_multiple_public_route_tables = var.multiple_public_route_tables


  private_dedicated_network_acl = true
  private_inbound_acl_rules     = local.acl_private
  private_outbound_acl_rules    = local.acl_private_outbound

  database_dedicated_network_acl = true
  database_inbound_acl_rules = [
    { # Allow all unrestricted inbound traffic for VPC network
      "cidr_block" : var.vpc_cidr,
      "from_port" : 0,
      "to_port" : 0,
      "protocol" : "-1",
      "rule_action" : "allow",
      "rule_number" : 100
    }
  ]
  database_outbound_acl_rules = [
    { # Allow all unrestricted outbound traffic for anywhere
      "cidr_block" : "0.0.0.0/0",
      "from_port" : 0,
      "to_port" : 0,
      "protocol" : "-1",
      "rule_action" : "allow",
      "rule_number" : 100
    }
  ]
  default_network_acl_ingress = [
    { # Allow all unrestricted inbound traffic for the VPC network
      "cidr_block"  = var.vpc_cidr
      "from_port"   = 0
      "to_port"     = 0
      "protocol"    = "-1"
      "action" = "allow"
      "rule_no" : 100
    }
  ]

  public_dedicated_network_acl = true
  public_inbound_acl_rules     = local.acl_public
  public_outbound_acl_rules    = local.acl_public_outbound

  create_vpc           = true
  enable_dns_hostnames = true
  enable_dns_support   = true

  enable_nat_gateway  = (length(var.public_subnets) > 0 && var.enable_nat_gateway)
  single_nat_gateway  = var.single_nat_gateway
  reuse_nat_ips       = var.reuse_nat_ips
  external_nat_ip_ids = var.external_nat_ip_ids

  create_database_subnet_group           = true
  create_database_subnet_route_table     = true
  create_database_internet_gateway_route = false

  enable_dhcp_options      = true
  dhcp_options_domain_name = var.dhcp_domain_name
  #dhcp_options_domain_name_servers = var.dhcp_dns

  map_public_ip_on_launch              = true
  enable_network_address_usage_metrics = true

  tags = local.all_tags
}
