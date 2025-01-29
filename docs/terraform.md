## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 5.80.0 |
| <a name="provider_cloudinit"></a> [cloudinit](#provider\_cloudinit) | 2.3.5 |
| <a name="provider_local"></a> [local](#provider\_local) | 2.5.2 |
| <a name="provider_tls"></a> [tls](#provider\_tls) | 4.0.6 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_tags"></a> [tags](#module\_tags) | cloudopsworks/tags/local | 1.0.9 |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | terraform-aws-modules/vpc/aws | ~> 5.0 |
| <a name="module_vpc_endpoints"></a> [vpc\_endpoints](#module\_vpc\_endpoints) | terraform-aws-modules/vpc/aws//modules/vpc-endpoints | ~> 5.0 |

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_log_group.log_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_flow_log.flow_logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/flow_log) | resource |
| [aws_iam_instance_profile.bastion](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile) | resource |
| [aws_iam_role.bastion](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.vpc_logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.vpc_logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy_attachment.bastion_admin](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_instance.bastion_server](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [aws_key_pair.bastion_key](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/key_pair) | resource |
| [aws_network_acl_rule.custom_private_acl_rule](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_acl_rule) | resource |
| [aws_network_acl_rule.custom_public_acl_rule](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_acl_rule) | resource |
| [aws_network_acl_rule.custom_public_outbound_acl_rule](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_acl_rule) | resource |
| [aws_network_acl_rule.db_acl_rules_in_for_internal](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_acl_rule) | resource |
| [aws_network_acl_rule.db_acl_rules_out_for_internal](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_acl_rule) | resource |
| [aws_network_acl_rule.private_acl_rules_in_for_internal](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_acl_rule) | resource |
| [aws_network_acl_rule.private_acl_rules_out_for_internal](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_acl_rule) | resource |
| [aws_network_acl_rule.public_acl_rules_in_for_internal](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_acl_rule) | resource |
| [aws_network_acl_rule.public_acl_rules_out_for_internal](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_acl_rule) | resource |
| [aws_secretsmanager_secret.bastion_private_key](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret) | resource |
| [aws_secretsmanager_secret.bastion_public_key](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret) | resource |
| [aws_secretsmanager_secret_version.bastion_private_key](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret_version) | resource |
| [aws_secretsmanager_secret_version.bastion_public_key](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/secretsmanager_secret_version) | resource |
| [aws_security_group.bastion](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.endpoints](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.ssh_admin](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group_rule.endpoints_ingress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.ssh-admin-ingress-vpn](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [local_file.keypair_priv_bastion](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |
| [tls_private_key.keypair_gen_bastion](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key) | resource |
| [aws_ami.ubuntu](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |
| [aws_iam_policy_document.generic_endpoint_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |
| [cloudinit_config.prometheus_server_cloudinit](https://registry.terraform.io/providers/hashicorp/cloudinit/latest/docs/data-sources/config) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_availability_zones"></a> [availability\_zones](#input\_availability\_zones) | n/a | `list(string)` | n/a | yes |
| <a name="input_bastion_size"></a> [bastion\_size](#input\_bastion\_size) | # (c) 2024 - Cloud Ops Works LLC - https://cloudops.works/ On GitHub: https://github.com/cloudopsworks Distributed Under Apache v2.0 License | `string` | `"t3a.micro"` | no |
| <a name="input_bastion_storage"></a> [bastion\_storage](#input\_bastion\_storage) | n/a | `string` | `"10"` | no |
| <a name="input_create_bastion"></a> [create\_bastion](#input\_create\_bastion) | n/a | `bool` | n/a | yes |
| <a name="input_database_subnets"></a> [database\_subnets](#input\_database\_subnets) | n/a | `list(string)` | n/a | yes |
| <a name="input_database_subnets_names"></a> [database\_subnets\_names](#input\_database\_subnets\_names) | n/a | `list(string)` | `[]` | no |
| <a name="input_default_endpoint"></a> [default\_endpoint](#input\_default\_endpoint) | n/a | `bool` | `true` | no |
| <a name="input_dhcp_dns"></a> [dhcp\_dns](#input\_dhcp\_dns) | n/a | `list(string)` | n/a | yes |
| <a name="input_dhcp_domain_name"></a> [dhcp\_domain\_name](#input\_dhcp\_domain\_name) | n/a | `string` | `"sample.com"` | no |
| <a name="input_docker_version_server"></a> [docker\_version\_server](#input\_docker\_version\_server) | n/a | `string` | `"18.09"` | no |
| <a name="input_enable_nat_gateway"></a> [enable\_nat\_gateway](#input\_enable\_nat\_gateway) | n/a | `bool` | `true` | no |
| <a name="input_endpoint_services"></a> [endpoint\_services](#input\_endpoint\_services) | n/a | <pre>list(object({<br/>    name        = string<br/>    type        = optional(string, "Interface")<br/>    private_dns = optional(bool, true)<br/>    policy      = optional(bool, false)<br/>  }))</pre> | `[]` | no |
| <a name="input_external_nat_ip_ids"></a> [external\_nat\_ip\_ids](#input\_external\_nat\_ip\_ids) | n/a | `list(string)` | `[]` | no |
| <a name="input_extra_tags"></a> [extra\_tags](#input\_extra\_tags) | n/a | `map(string)` | `{}` | no |
| <a name="input_flow_logs_type"></a> [flow\_logs\_type](#input\_flow\_logs\_type) | n/a | `string` | `"REJECT"` | no |
| <a name="input_internal_allow_cidrs"></a> [internal\_allow\_cidrs](#input\_internal\_allow\_cidrs) | n/a | `list(string)` | `[]` | no |
| <a name="input_intra_subnets"></a> [intra\_subnets](#input\_intra\_subnets) | A list of intra subnets inside the VPC | `list(string)` | `[]` | no |
| <a name="input_is_hub"></a> [is\_hub](#input\_is\_hub) | Establish this is a HUB or spoke configuration | `bool` | `false` | no |
| <a name="input_multiple_intra_route_tables"></a> [multiple\_intra\_route\_tables](#input\_multiple\_intra\_route\_tables) | n/a | `bool` | `false` | no |
| <a name="input_multiple_public_route_tables"></a> [multiple\_public\_route\_tables](#input\_multiple\_public\_route\_tables) | n/a | `bool` | `false` | no |
| <a name="input_org"></a> [org](#input\_org) | n/a | <pre>object({<br/>    organization_name = string<br/>    organization_unit = string<br/>    environment_type  = string<br/>    environment_name  = string<br/>  })</pre> | n/a | yes |
| <a name="input_private_acl_rules"></a> [private\_acl\_rules](#input\_private\_acl\_rules) | n/a | <pre>list(object({<br/>    cidr_block  = string,<br/>    from_port   = optional(number, 0),<br/>    to_port     = optional(number, 0),<br/>    protocol    = string,<br/>    rule_action = string,<br/>  }))</pre> | `[]` | no |
| <a name="input_private_subnets"></a> [private\_subnets](#input\_private\_subnets) | n/a | `list(any)` | n/a | yes |
| <a name="input_private_subnets_names"></a> [private\_subnets\_names](#input\_private\_subnets\_names) | n/a | `list(string)` | `[]` | no |
| <a name="input_public_acl_rules"></a> [public\_acl\_rules](#input\_public\_acl\_rules) | n/a | <pre>list(object({<br/>    cidr_block  = string,<br/>    from_port   = optional(number, 0),<br/>    to_port     = optional(number, 0),<br/>    protocol    = string,<br/>    rule_action = string,<br/>  }))</pre> | `[]` | no |
| <a name="input_public_outbound_rules"></a> [public\_outbound\_rules](#input\_public\_outbound\_rules) | n/a | <pre>list(object({<br/>    cidr_block  = string,<br/>    from_port   = optional(number, 0),<br/>    to_port     = optional(number, 0),<br/>    protocol    = string,<br/>    rule_action = string,<br/>  }))</pre> | `[]` | no |
| <a name="input_public_subnets"></a> [public\_subnets](#input\_public\_subnets) | n/a | `list(any)` | n/a | yes |
| <a name="input_public_subnets_names"></a> [public\_subnets\_names](#input\_public\_subnets\_names) | n/a | `list(string)` | `[]` | no |
| <a name="input_reuse_nat_ips"></a> [reuse\_nat\_ips](#input\_reuse\_nat\_ips) | n/a | `bool` | `false` | no |
| <a name="input_secrets_manager_enabled"></a> [secrets\_manager\_enabled](#input\_secrets\_manager\_enabled) | n/a | `bool` | `false` | no |
| <a name="input_single_nat_gateway"></a> [single\_nat\_gateway](#input\_single\_nat\_gateway) | n/a | `bool` | `true` | no |
| <a name="input_spoke_def"></a> [spoke\_def](#input\_spoke\_def) | n/a | `string` | `"001"` | no |
| <a name="input_vpc_cidr"></a> [vpc\_cidr](#input\_vpc\_cidr) | n/a | `string` | n/a | yes |
| <a name="input_vpn_accesses"></a> [vpn\_accesses](#input\_vpn\_accesses) | n/a | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_bastion_key"></a> [bastion\_key](#output\_bastion\_key) | # (c) 2024 - Cloud Ops Works LLC - https://cloudops.works/ On GitHub: https://github.com/cloudopsworks Distributed Under Apache v2.0 License |
| <a name="output_bastion_public_address"></a> [bastion\_public\_address](#output\_bastion\_public\_address) | n/a |
| <a name="output_bastion_public_ip"></a> [bastion\_public\_ip](#output\_bastion\_public\_ip) | n/a |
| <a name="output_bastion_security_group_id"></a> [bastion\_security\_group\_id](#output\_bastion\_security\_group\_id) | n/a |
| <a name="output_cloudwatch_log_group"></a> [cloudwatch\_log\_group](#output\_cloudwatch\_log\_group) | n/a |
| <a name="output_database_route_table_ids"></a> [database\_route\_table\_ids](#output\_database\_route\_table\_ids) | n/a |
| <a name="output_database_subnet_group"></a> [database\_subnet\_group](#output\_database\_subnet\_group) | n/a |
| <a name="output_database_subnet_group_name"></a> [database\_subnet\_group\_name](#output\_database\_subnet\_group\_name) | n/a |
| <a name="output_database_subnets"></a> [database\_subnets](#output\_database\_subnets) | n/a |
| <a name="output_flowlogs_role_arn"></a> [flowlogs\_role\_arn](#output\_flowlogs\_role\_arn) | n/a |
| <a name="output_intra_route_table_ids"></a> [intra\_route\_table\_ids](#output\_intra\_route\_table\_ids) | n/a |
| <a name="output_intra_subnets"></a> [intra\_subnets](#output\_intra\_subnets) | n/a |
| <a name="output_nat_address"></a> [nat\_address](#output\_nat\_address) | n/a |
| <a name="output_private_route_table_ids"></a> [private\_route\_table\_ids](#output\_private\_route\_table\_ids) | n/a |
| <a name="output_private_subnets"></a> [private\_subnets](#output\_private\_subnets) | n/a |
| <a name="output_public_route_table_ids"></a> [public\_route\_table\_ids](#output\_public\_route\_table\_ids) | n/a |
| <a name="output_public_subnets"></a> [public\_subnets](#output\_public\_subnets) | n/a |
| <a name="output_ssh_admin_security_group_id"></a> [ssh\_admin\_security\_group\_id](#output\_ssh\_admin\_security\_group\_id) | n/a |
| <a name="output_vpc_cidr_block"></a> [vpc\_cidr\_block](#output\_vpc\_cidr\_block) | n/a |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | # (c) 2024 - Cloud Ops Works LLC - https://cloudops.works/ On GitHub: https://github.com/cloudopsworks Distributed Under Apache v2.0 License |
| <a name="output_vpc_name"></a> [vpc\_name](#output\_vpc\_name) | n/a |
| <a name="output_vpn_accesses"></a> [vpn\_accesses](#output\_vpn\_accesses) | n/a |
