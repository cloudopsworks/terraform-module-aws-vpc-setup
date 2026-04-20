locals {
  local_vars  = yamldecode(file("./inputs.yaml"))
  spoke_vars  = yamldecode(file(find_in_parent_folders("spoke-inputs.yaml")))
  region_vars = yamldecode(file(find_in_parent_folders("region-inputs.yaml")))
  env_vars    = yamldecode(file(find_in_parent_folders("env-inputs.yaml")))
  global_vars = yamldecode(file(find_in_parent_folders("global-inputs.yaml")))

  local_tags  = jsondecode(file("./local-tags.json"))
  spoke_tags  = jsondecode(file(find_in_parent_folders("spoke-tags.json")))
  region_tags = jsondecode(file(find_in_parent_folders("region-tags.json")))
  env_tags    = jsondecode(file(find_in_parent_folders("env-tags.json")))
  global_tags = jsondecode(file(find_in_parent_folders("global-tags.json")))

  tags = merge(
    local.global_tags,
    local.env_tags,
    local.region_tags,
    local.spoke_tags,
    local.local_tags
  )
}

include "root" {
  path = find_in_parent_folders("{{ .RootFileName }}")
}

terraform {
  source = "{{ .sourceUrl }}"
}

inputs = {
  is_hub    = {{ .is_hub }}
  org       = local.env_vars.org
  spoke_def = local.spoke_vars.spoke

  vpc = {
    cidr_block          = local.local_vars.vpc.cidr_block
    availability_zones  = local.local_vars.vpc.availability_zones
    public_ip_on_launch = try(local.local_vars.vpc.public_ip_on_launch, true)

    subnet_cidr_blocks = {
      public   = try(local.local_vars.vpc.subnet_cidr_blocks.public, [])
      private  = try(local.local_vars.vpc.subnet_cidr_blocks.private, [])
      database = try(local.local_vars.vpc.subnet_cidr_blocks.database, [])
      intra    = try(local.local_vars.vpc.subnet_cidr_blocks.intra, [])
    }

    dhcp_option = {
      dns    = try(local.local_vars.vpc.dhcp_option.dns, [])
      domain = { name = try(local.local_vars.vpc.dhcp_option.domain.name, "example.com") }
    }

    nat_gateway = {
      enabled   = try(local.local_vars.vpc.nat_gateway.enabled, true)
      single    = try(local.local_vars.vpc.nat_gateway.single, true)
      reuse_eip = try(local.local_vars.vpc.nat_gateway.reuse_eip, false)
      eip_ids   = try(local.local_vars.vpc.nat_gateway.eip_ids, [])
    }

    nat_instance = {
      enabled       = try(local.local_vars.vpc.nat_instance.enabled, false)
      size          = try(local.local_vars.vpc.nat_instance.size, "t4g.micro")
      allowed_cidrs = try(local.local_vars.vpc.nat_instance.allowed_cidrs, [])
      spot          = try(local.local_vars.vpc.nat_instance.spot, false)
      high_volume   = try(local.local_vars.vpc.nat_instance.high_volume, false)
    }

    flow_logs = {
      type      = try(local.local_vars.vpc.flow_logs.type, "REJECT")
      retention = try(local.local_vars.vpc.flow_logs.retention, 30)
    }

    vpn_gateway  = { enabled = try(local.local_vars.vpc.vpn_gateway.enabled, false) }
    route_tables = {
      multiple_intra  = try(local.local_vars.vpc.route_tables.multiple_intra, false)
      multiple_public = try(local.local_vars.vpc.route_tables.multiple_public, false)
      intra_nat       = try(local.local_vars.vpc.route_tables.intra_nat, false)
    }

    internal_allow_cidrs = try(local.local_vars.vpc.internal_allow_cidrs, [])
    default_endpoint     = { enabled = try(local.local_vars.vpc.default_endpoint.enabled, true) }
    secrets_manager      = { enabled = try(local.local_vars.vpc.secrets_manager.enabled, false) }

    acl_rules = {
      public          = try(local.local_vars.vpc.acl_rules.public, [])
      public_outbound = try(local.local_vars.vpc.acl_rules.public_outbound, [])
      private         = try(local.local_vars.vpc.acl_rules.private, [])
    }
  }

  bastion = {
    create             = try(local.local_vars.bastion.create, false)
    vm_size            = try(local.local_vars.bastion.vm_size, "t3a.micro")
    disk_size          = try(local.local_vars.bastion.disk_size, 10)
    state              = try(local.local_vars.bastion.state, "stopped")
    vendor             = try(local.local_vars.bastion.vendor, "ubuntu")
    docker_version     = try(local.local_vars.bastion.docker_version, "26.0")
    devops_accelerator = try(local.local_vars.bastion.devops_accelerator, false)
  }

  vpn_accesses      = try(local.local_vars.vpn_accesses, [])
  endpoint_services = try(local.local_vars.endpoint_services, [])
  extra_tags        = local.tags
}
