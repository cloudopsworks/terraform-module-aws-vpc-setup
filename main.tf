##
# (c) 2021-2025
#     Cloud Ops Works LLC - https://cloudops.works/
#     Find us on:
#       GitHub: https://github.com/cloudopsworks
#       WebSite: https://cloudops.works
#     Distributed Under Apache v2.0 License
#
locals {
  acl_private_default = [
    { # Allow all unrestricted inbound traffic for VPC network
      cidr_block  = var.vpc.cidr_block
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      rule_action = "allow"
      rule_number = 100
    },
    { # Allow Backport binding TCP Except RDP < 3389
      cidr_block  = "0.0.0.0/0"
      from_port   = 1024
      to_port     = 3388
      protocol    = "tcp"
      rule_action = "allow"
      rule_number = 200
    },
    { # Allow Backport binding TCP Except RDP > 3389
      cidr_block  = "0.0.0.0/0"
      from_port   = 3390
      to_port     = 65535
      protocol    = "tcp"
      rule_action = "allow"
      rule_number = 201
    },
    { # Allow Backport binding UDP Except RDP < 3389
      cidr_block  = "0.0.0.0/0"
      from_port   = 1024
      to_port     = 3388
      protocol    = "udp"
      rule_action = "allow"
      rule_number = 300
    },
    { # Allow Backport binding UDP Except RDP > 3389
      cidr_block  = "0.0.0.0/0"
      from_port   = 3390
      to_port     = 65535
      protocol    = "udp"
      rule_action = "allow"
      rule_number = 301
    }
  ]
  private_outbound_acl_rules_default = [
    { # Allow all unrestricted outbound traffic for VPC network
      cidr_block  = var.vpc.cidr_block
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      rule_action = "allow"
      rule_number = 100
    },
    { # Allow binding TCP for service that specify Foreign Address = 0.0.0.0:*
      cidr_block  = "0.0.0.0/0"
      from_port   = 0
      to_port     = 65535
      protocol    = "tcp"
      rule_action = "allow"
      rule_number = 200
    },
    { # Allow binding UDP for service that specify Foreign Address = 0.0.0.0:*
      cidr_block  = "0.0.0.0/0"
      from_port   = 0
      to_port     = 65535
      protocol    = "udp"
      rule_action = "allow"
      rule_number = 300
    }
  ]
  acl_public_vpn = concat([for access in var.vpn_accesses :
    { # Allow SSH Access for bastion hosts
      cidr_block  = access
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      rule_action = "allow"
      rule_number = 400 + index(var.vpn_accesses, access)
    }
    ],
    [for access in var.vpn_accesses :
      { # Allow RDP Access for bastion hosts
        cidr_block  = access
        from_port   = 3389
        to_port     = 3389
        protocol    = "tcp"
        rule_action = "allow"
        rule_number = 450 + index(var.vpn_accesses, access)
      }
    ]
  )
  acl_public_default = [
    { # Allow all from internal network Instances behind NAT will be permitted to go out
      cidr_block  = var.vpc.cidr_block
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      rule_action = "allow"
      rule_number = 100
    },
    { # Allow HTTP Access
      cidr_block  = "0.0.0.0/0"
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      rule_action = "allow"
      rule_number = 200
    },
    { # Allow HTTPS Access
      cidr_block  = "0.0.0.0/0"
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      rule_action = "allow"
      rule_number = 300
    },
    { # Allow Backport binding TCP except RDP < 3389
      cidr_block  = "0.0.0.0/0"
      from_port   = 1024
      to_port     = 3388
      protocol    = "tcp"
      rule_action = "allow"
      rule_number = 500
    },
    { # Allow Backport binding TCP except RDP > 3389
      cidr_block  = "0.0.0.0/0"
      from_port   = 3390
      to_port     = 65535
      protocol    = "tcp"
      rule_action = "allow"
      rule_number = 501
    },
    { # Allow access to SMTP, specially if there are instances behind NAT
      cidr_block  = "0.0.0.0/0"
      from_port   = 465
      to_port     = 465
      protocol    = "tcp"
      rule_action = "allow"
      rule_number = 600
    },
    { # Allow access to SMTP, specially if there are instances behind NAT
      cidr_block  = "0.0.0.0/0"
      from_port   = 25
      to_port     = 25
      protocol    = "tcp"
      rule_action = "allow"
      rule_number = 700
    },
    { # Allow access to SMTP, specially if there are instances behind NAT
      cidr_block  = "0.0.0.0/0"
      from_port   = 587
      to_port     = 587
      protocol    = "tcp"
      rule_action = "allow"
      rule_number = 800
    }
    # ,
    # { # Allow Backport binding UDP
    #   "cidr_block"= "0.0.0.0/0"
    #   "from_port"= 1025
    #   "to_port"= 65535
    #   "protocol"= "udp"
    #   "rule_action"= "allow"
    #   "rule_number": 1300
    # }
  ]
  acl_public_outbound_default = [
    { # Allow unrestricted Outbound traffic to VPC internal addresses
      cidr_block  = var.vpc.cidr_block
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      rule_action = "allow"
      rule_number = 100
    },
    { # Allow Outbound traffic for ephemeral ports (NAT+NLB/ALB)
      cidr_block  = "0.0.0.0/0"
      from_port   = 1024
      to_port     = 65535
      protocol    = "tcp"
      rule_action = "allow"
      rule_number = 200
    },
    { # Allow Outbound traffic for HTTP (NAT)
      cidr_block  = "0.0.0.0/0"
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      rule_action = "allow"
      rule_number = 300
    },
    { # Allow Outbound traffic for HTTPS (NAT)
      cidr_block  = "0.0.0.0/0"
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      rule_action = "allow"
      rule_number = 400
    },
    { # Allow Outbound traffic for SMTPS (NAT)
      cidr_block  = "0.0.0.0/0"
      from_port   = 465
      to_port     = 465
      protocol    = "tcp"
      rule_action = "allow"
      rule_number = 500
    },
    { # Allow Outbound traffic for SMTP (NAT)
      cidr_block  = "0.0.0.0/0"
      from_port   = 25
      to_port     = 25
      protocol    = "tcp"
      rule_action = "allow"
      rule_number = 600
    },
    { # Allow Outbound traffic for SMTPS (NAT)
      cidr_block  = "0.0.0.0/0"
      from_port   = 587
      to_port     = 587
      protocol    = "tcp"
      rule_action = "allow"
      rule_number = 700
    },
    { # Allow Outbound traffic for DNS (NAT)
      cidr_block  = "0.0.0.0/0"
      from_port   = 53
      to_port     = 53
      protocol    = "tcp"
      rule_action = "allow"
      rule_number = 800
    },
    { # Allow Outbound traffic for DNS (NAT)
      cidr_block  = "0.0.0.0/0"
      from_port   = 53
      to_port     = 53
      protocol    = "udp"
      rule_action = "allow"
      rule_number = 900
    }
  ]
  acl_private          = local.acl_private_default
  acl_private_outbound = local.private_outbound_acl_rules_default
  acl_public           = concat(local.acl_public_default, local.acl_public_vpn)
  acl_public_outbound  = local.acl_public_outbound_default
  acl_intra            = local.acl_private_default
  acl_intra_outbound   = local.private_outbound_acl_rules_default
  use_nat_gateway      = var.vpc.nat_gateway.enabled && !var.vpc.nat_instance.enabled
  use_nat_instance     = var.vpc.nat_instance.enabled
}

module "vpc" {
  source                              = "terraform-aws-modules/vpc/aws"
  version                             = "~> 6.0"
  name                                = "vpc-${local.system_name}"
  cidr                                = var.vpc.cidr_block
  azs                                 = var.vpc.availability_zones
  private_subnets                     = var.vpc.subnet_cidr_blocks.private
  private_subnet_names                = var.vpc.subnet_names.private
  public_subnets                      = var.vpc.subnet_cidr_blocks.public
  public_subnet_names                 = var.vpc.subnet_names.public
  database_subnets                    = var.vpc.subnet_cidr_blocks.database
  database_subnet_names               = var.vpc.subnet_names.database
  intra_subnets                       = var.vpc.subnet_cidr_blocks.intra
  intra_dedicated_network_acl         = true
  intra_inbound_acl_rules             = local.acl_intra
  intra_outbound_acl_rules            = local.acl_intra_outbound
  create_multiple_intra_route_tables  = var.vpc.route_tables.multiple_intra
  create_multiple_public_route_tables = var.vpc.route_tables.multiple_public

  private_dedicated_network_acl = true
  private_inbound_acl_rules     = local.acl_private
  private_outbound_acl_rules    = local.acl_private_outbound

  database_dedicated_network_acl = true
  database_inbound_acl_rules = [
    { # Allow all unrestricted inbound traffic for VPC network
      cidr_block  = var.vpc.cidr_block
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      rule_action = "allow"
      rule_number = 100
    }
  ]
  database_outbound_acl_rules = [
    { # Allow all unrestricted outbound traffic for anywhere
      cidr_block  = "0.0.0.0/0"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      rule_action = "allow"
      rule_number = 100
    }
  ]
  default_network_acl_ingress = [
    { # Allow all unrestricted inbound traffic for the VPC network
      cidr_block = var.vpc.cidr_block
      from_port  = 0
      to_port    = 0
      protocol   = "-1"
      action     = "allow"
      rule_no    = 100
    }
  ]

  public_dedicated_network_acl = true
  public_inbound_acl_rules     = local.acl_public
  public_outbound_acl_rules    = local.acl_public_outbound

  create_vpc           = true
  enable_dns_hostnames = true
  enable_dns_support   = true

  enable_nat_gateway  = (length(var.vpc.subnet_cidr_blocks.public) > 0 && local.use_nat_gateway)
  single_nat_gateway  = var.vpc.nat_gateway.single
  reuse_nat_ips       = var.vpc.nat_gateway.reuse_eip
  external_nat_ip_ids = var.vpc.nat_gateway.eip_ids

  create_database_subnet_group           = true
  create_database_subnet_route_table     = true
  create_database_internet_gateway_route = false

  enable_dhcp_options      = true
  dhcp_options_domain_name = var.vpc.dhcp_option.domain.name
  #dhcp_options_domain_name_servers = var.vpc.dhcp_option.dns

  map_public_ip_on_launch              = var.vpc.public_ip_on_launch
  enable_network_address_usage_metrics = true

  enable_vpn_gateway = var.vpc.vpn_gateway.enabled

  tags = local.all_tags
}

resource "aws_ec2_tag" "nat_gw_eni" {
  for_each = merge([
    for eni_index in range(var.vpc.nat_gateway.single ? 1 : length(var.vpc.subnet_cidr_blocks.public)) : {
      for k, v in local.all_tags : "${eni_index}-${k}" => {
        index     = eni_index
        tag_key   = k
        tag_value = v
      }
    } if(length(var.vpc.subnet_cidr_blocks.public) > 0 && local.use_nat_gateway)
  ]...)
  resource_id = module.vpc.natgw_interface_ids[each.value.index]
  key         = each.value.tag_key
  value       = each.value.tag_value
}