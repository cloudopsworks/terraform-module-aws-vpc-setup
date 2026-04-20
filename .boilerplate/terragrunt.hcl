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
{{ if .nat_eip_enabled }}
dependency "eip" {
  config_path                             = "{{ .nat_eip_path }}"
  mock_outputs_allowed_terraform_commands = ["validate"]
  mock_outputs = {
    public_ips = [
      "123.123.123.1",
      "123.123.123.2",
      "123.123.123.3",
    ]
    public_ip_ids = [
      "eipalloc-12345678901234567",
      "eipalloc-12345678901234567",
      "eipalloc-12345678901234567",
    ]
  }
}
{{ end }}
terraform {
  source = "{{ .sourceUrl }}"
}

inputs = {
  is_hub     = {{ .is_hub }}
  org        = local.env_vars.org
  spoke_def  = local.spoke_vars.spoke
  {{- range .requiredVariables }}
  {{- if ne .Name "org" }}
  {{- if and $.nat_eip_enabled (eq .Name "vpc") }}
  vpc = merge(local.local_vars.vpc, {
      nat_gateway = {
        enabled = try(local.local_vars.vpc.nat_gateway.enabled, true)
        single  = try(local.local_vars.vpc.nat_gateway.single, true)
        reuse_eip = true
        eip_ids = dependency.eip.outputs.public_ip_ids
      }
    }
  )
  {{- else }}
  {{ .Name }} =
  {{- end }}
  {{- end }}
  {{- end }}
  {{- range .optionalVariables }}
  {{- if not (eq .Name "extra_tags" "is_hub" "spoke_def" "org") }}
  {{ .Name }} = try(local.local_vars.{{ .Name }}, {{ .DefaultValue }})
  {{- end }}
  {{- end }}
  extra_tags = local.tags
}