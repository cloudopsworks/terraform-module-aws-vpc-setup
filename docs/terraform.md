## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3 |
| <a name="requirement_archive"></a> [archive](#requirement\_archive) | ~> 2.7 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 6.35 |
| <a name="requirement_cloudinit"></a> [cloudinit](#requirement\_cloudinit) | ~> 2.3 |
| <a name="requirement_local"></a> [local](#requirement\_local) | ~> 2.5 |
| <a name="requirement_tls"></a> [tls](#requirement\_tls) | ~> 4.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 6.41.0 |
| <a name="provider_cloudinit"></a> [cloudinit](#provider\_cloudinit) | 2.3.7 |
| <a name="provider_local"></a> [local](#provider\_local) | 2.8.0 |
| <a name="provider_tls"></a> [tls](#provider\_tls) | 4.2.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_alternat_instances"></a> [alternat\_instances](#module\_alternat\_instances) | chime/alternat/aws | ~> 0.9 |
| <a name="module_nat_instance"></a> [nat\_instance](#module\_nat\_instance) | git::https://github.com/cloudopsworks/terraform-aws-fck-nat.git// | main |
| <a name="module_tags"></a> [tags](#module\_tags) | cloudopsworks/tags/local | 1.0.9 |
| <a name="module_vpc"></a> [vpc](#module\_vpc) | terraform-aws-modules/vpc/aws | ~> 6.0 |
| <a name="module_vpc_endpoints"></a> [vpc\_endpoints](#module\_vpc\_endpoints) | terraform-aws-modules/vpc/aws//modules/vpc-endpoints | ~> 6.0 |

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_log_group.log_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_ec2_instance_state.bastion_server](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_instance_state) | resource |
| [aws_ec2_tag.nat_gw_eni](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ec2_tag) | resource |
| [aws_eip.nat_ec2_instance](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) | resource |
| [aws_flow_log.flow_logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/flow_log) | resource |
| [aws_iam_instance_profile.bastion](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile) | resource |
| [aws_iam_role.bastion](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.vpc_logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy.extra_bastion_permissions](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy.vpc_logs](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy) | resource |
| [aws_iam_role_policy_attachment.bastion_ssm](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_instance.bastion_server](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [aws_key_pair.bastion_key](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/key_pair) | resource |
| [aws_network_acl_rule.custom_private_acl_rule](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_acl_rule) | resource |
| [aws_network_acl_rule.custom_public_acl_rule](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_acl_rule) | resource |
| [aws_network_acl_rule.custom_public_outbound_acl_rule](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_acl_rule) | resource |
| [aws_network_acl_rule.db_acl_rules_in_for_internal](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_acl_rule) | resource |
| [aws_network_acl_rule.db_acl_rules_out_for_internal](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_acl_rule) | resource |
| [aws_network_acl_rule.private_acl_rules_in_for_internal](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_acl_rule) | resource |
| [aws_network_acl_rule.private_acl_rules_in_for_intra](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_acl_rule) | resource |
| [aws_network_acl_rule.private_acl_rules_out_for_internal](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_acl_rule) | resource |
| [aws_network_acl_rule.private_acl_rules_out_for_intra](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/network_acl_rule) | resource |
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
| [aws_security_group_rule.ssh-admin-local](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_ssm_parameter.tronador_accelerate_bastion_instance](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |
| [aws_ssm_parameter.tronador_accelerate_bastion_instance_sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |
| [aws_ssm_parameter.tronador_accelerate_bastion_instance_user](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |
| [aws_ssm_parameter.tronador_accelerate_bastion_key](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ssm_parameter) | resource |
| [local_file.keypair_priv_bastion](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |
| [tls_private_key.keypair_gen_bastion](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key) | resource |
| [aws_ami.ubuntu](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |
| [aws_iam_policy_document.extra_bastion_permissions](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_iam_policy_document.generic_endpoint_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |
| [aws_region.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/region) | data source |
| [aws_subnet.alternat_subnet](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/subnet) | data source |
| [cloudinit_config.prometheus_server_cloudinit](https://registry.terraform.io/providers/hashicorp/cloudinit/latest/docs/data-sources/config) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bastion"></a> [bastion](#input\_bastion) | Bastion host configuration | <pre>object({<br/>    create             = optional(bool, false)         # (Optional) Create a bastion host in the first public subnet, default: false<br/>    vm_size            = optional(string, "t3a.micro") # (Optional) EC2 instance type for the bastion, default: "t3a.micro"<br/>    disk_size          = optional(number, 10)          # (Optional) Root EBS volume size in GB, default: 10<br/>    state              = optional(string, "stopped")   # (Optional) Desired instance state: running or stopped, default: "stopped"<br/>    vendor             = optional(string, "ubuntu")    # (Optional) OS vendor: ubuntu, amazon, centos, or rhel, default: "ubuntu"<br/>    docker_version     = optional(string, "26.0")      # (Optional) Docker engine version to install, default: "26.0"<br/>    devops_accelerator = optional(bool, false)         # (Optional) Publish bastion metadata to SSM Parameter Store for DevOps Accelerator, default: false<br/>    extra_iam          = optional(any, [])             # (Optional) Additional IAM policy statement objects to attach to the bastion IAM role<br/>  })</pre> | `{}` | no |
| <a name="input_endpoint_services"></a> [endpoint\_services](#input\_endpoint\_services) | Additional VPC endpoint services to create beyond the default S3 gateway endpoint | `any` | `[]` | no |
| <a name="input_extra_tags"></a> [extra\_tags](#input\_extra\_tags) | Extra tags to add to the resources | `map(string)` | `{}` | no |
| <a name="input_is_hub"></a> [is\_hub](#input\_is\_hub) | Is this a hub or spoke configuration? | `bool` | `false` | no |
| <a name="input_org"></a> [org](#input\_org) | Organization details | <pre>object({<br/>    organization_name = string<br/>    organization_unit = string<br/>    environment_type  = string<br/>    environment_name  = string<br/>  })</pre> | n/a | yes |
| <a name="input_spoke_def"></a> [spoke\_def](#input\_spoke\_def) | Spoke ID Number, must be a 3 digit number | `string` | `"001"` | no |
| <a name="input_vpc"></a> [vpc](#input\_vpc) | VPC configuration | <pre>object({<br/>    cidr_block          = string               # (Required) CIDR block for the VPC, e.g. "10.0.0.0/16"<br/>    availability_zones  = list(string)         # (Required) List of AZ names, e.g. ["us-east-1a","us-east-1b"]<br/>    public_ip_on_launch = optional(bool, true) # (Optional) Map a public IP to instances launched in public subnets, default: true<br/><br/>    subnet_cidr_blocks = optional(object({<br/>      public   = optional(list(string), []) # (Optional) Public subnet CIDR blocks<br/>      private  = optional(list(string), []) # (Optional) Private subnet CIDR blocks<br/>      database = optional(list(string), []) # (Optional) Database subnet CIDR blocks<br/>      intra    = optional(list(string), []) # (Optional) Intra (isolated, no internet) subnet CIDR blocks<br/>    }), {})<br/><br/>    subnet_names = optional(object({<br/>      public   = optional(list(string), []) # (Optional) Names for public subnets, positionally matched to subnet_cidr_blocks.public<br/>      private  = optional(list(string), []) # (Optional) Names for private subnets<br/>      database = optional(list(string), []) # (Optional) Names for database subnets<br/>    }), {})<br/><br/>    dhcp_option = optional(object({<br/>      dns = optional(list(string), []) # (Optional) DNS server IP addresses for DHCP options set<br/>      domain = optional(object({<br/>        name = optional(string, "sample.com") # (Optional) Domain name suffix for DHCP options, default: "sample.com"<br/>      }), {})<br/>    }), {})<br/><br/>    nat_gateway = optional(object({<br/>      enabled   = optional(bool, true)       # (Optional) Create NAT gateway(s), default: true<br/>      single    = optional(bool, true)       # (Optional) Deploy a single NAT gateway shared across all AZs, default: true<br/>      reuse_eip = optional(bool, false)      # (Optional) Reuse pre-allocated Elastic IPs instead of creating new ones, default: false<br/>      eip_ids   = optional(list(string), []) # (Optional) Existing EIP allocation IDs to use when reuse_eip=true<br/>    }), {})<br/><br/>    nat_instance = optional(object({<br/>      enabled       = optional(bool, false)         # (Optional) Use a NAT instance instead of NAT gateway (overrides nat_gateway), default: false<br/>      size          = optional(string, "t4g.micro") # (Optional) EC2 instance type for the NAT instance, default: "t4g.micro"<br/>      allowed_cidrs = optional(list(string), [])    # (Optional) CIDR blocks allowed to route through the NAT instance<br/>      spot          = optional(bool, false)         # (Optional) Use a Spot instance for the NAT instance, default: false<br/>      high_volume   = optional(bool, false)         # (Optional) Deploy the high-throughput alternat solution, default: false<br/>    }), {})<br/><br/>    flow_logs = optional(object({<br/>      type      = optional(string, "REJECT") # (Optional) Traffic to capture: ACCEPT, REJECT, or ALL, default: "REJECT"<br/>      retention = optional(number, 30)       # (Optional) CloudWatch log group retention period in days, default: 30<br/>    }), {})<br/><br/>    vpn_gateway = optional(object({<br/>      enabled = optional(bool, false) # (Optional) Attach a Virtual Private Gateway to the VPC, default: false<br/>    }), {})<br/><br/>    route_tables = optional(object({<br/>      multiple_intra  = optional(bool, false) # (Optional) Create one route table per intra subnet instead of sharing, default: false<br/>      multiple_public = optional(bool, false) # (Optional) Create one route table per public subnet instead of sharing, default: false<br/>      intra_nat       = optional(bool, false) # (Optional) Route intra subnet egress through the NAT gateway, default: false<br/>    }), {})<br/><br/>    internal_allow_cidrs = optional(list(string), []) # (Optional) CIDR blocks granted unrestricted access via network ACLs and the SSH security group<br/><br/>    default_endpoint = optional(object({<br/>      enabled = optional(bool, true) # (Optional) Create the default S3 Gateway VPC endpoint, default: true<br/>    }), {})<br/><br/>    secrets_manager = optional(object({<br/>      enabled = optional(bool, false) # (Optional) Store bastion SSH keys in AWS Secrets Manager, default: false<br/>    }), {})<br/><br/>    acl_rules = optional(object({<br/>      public = optional(list(object({<br/>        cidr_block  = string<br/>        from_port   = optional(number, 0)<br/>        to_port     = optional(number, 0)<br/>        protocol    = string<br/>        rule_action = string<br/>      })), []) # (Optional) Extra inbound network ACL rules for public subnets (rule numbers start at 1000)<br/>      public_outbound = optional(list(object({<br/>        cidr_block  = string<br/>        from_port   = optional(number, 0)<br/>        to_port     = optional(number, 0)<br/>        protocol    = string<br/>        rule_action = string<br/>      })), []) # (Optional) Extra outbound network ACL rules for public subnets (rule numbers start at 1000)<br/>      private = optional(list(object({<br/>        cidr_block  = string<br/>        from_port   = optional(number, 0)<br/>        to_port     = optional(number, 0)<br/>        protocol    = string<br/>        rule_action = string<br/>      })), []) # (Optional) Extra inbound network ACL rules for private subnets (rule numbers start at 1000)<br/>    }), {})<br/>  })</pre> | n/a | yes |
| <a name="input_vpn_accesses"></a> [vpn\_accesses](#input\_vpn\_accesses) | CIDR blocks permitted for VPN/external SSH access to the bastion and public network ACLs | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_bastion_key"></a> [bastion\_key](#output\_bastion\_key) | # (c) 2021-2025 Cloud Ops Works LLC - https://cloudops.works/ Find us on: GitHub: https://github.com/cloudopsworks WebSite: https://cloudops.works Distributed Under Apache v2.0 License |
| <a name="output_bastion_private_key_secret"></a> [bastion\_private\_key\_secret](#output\_bastion\_private\_key\_secret) | n/a |
| <a name="output_bastion_private_key_secret_arn"></a> [bastion\_private\_key\_secret\_arn](#output\_bastion\_private\_key\_secret\_arn) | n/a |
| <a name="output_bastion_public_address"></a> [bastion\_public\_address](#output\_bastion\_public\_address) | n/a |
| <a name="output_bastion_public_ip"></a> [bastion\_public\_ip](#output\_bastion\_public\_ip) | n/a |
| <a name="output_bastion_security_group_id"></a> [bastion\_security\_group\_id](#output\_bastion\_security\_group\_id) | n/a |
| <a name="output_bastion_ssm_parameter"></a> [bastion\_ssm\_parameter](#output\_bastion\_ssm\_parameter) | n/a |
| <a name="output_bastion_ssm_parameter_bastion_key"></a> [bastion\_ssm\_parameter\_bastion\_key](#output\_bastion\_ssm\_parameter\_bastion\_key) | n/a |
| <a name="output_bastion_ssm_parameter_user"></a> [bastion\_ssm\_parameter\_user](#output\_bastion\_ssm\_parameter\_user) | n/a |
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
| <a name="output_public_network_acl_id"></a> [public\_network\_acl\_id](#output\_public\_network\_acl\_id) | n/a |
| <a name="output_public_route_table_ids"></a> [public\_route\_table\_ids](#output\_public\_route\_table\_ids) | n/a |
| <a name="output_public_subnets"></a> [public\_subnets](#output\_public\_subnets) | n/a |
| <a name="output_ssh_admin_security_group_id"></a> [ssh\_admin\_security\_group\_id](#output\_ssh\_admin\_security\_group\_id) | n/a |
| <a name="output_vpc_cidr_block"></a> [vpc\_cidr\_block](#output\_vpc\_cidr\_block) | n/a |
| <a name="output_vpc_id"></a> [vpc\_id](#output\_vpc\_id) | # (c) 2021-2025 Cloud Ops Works LLC - https://cloudops.works/ Find us on: GitHub: https://github.com/cloudopsworks WebSite: https://cloudops.works Distributed Under Apache v2.0 License |
| <a name="output_vpc_name"></a> [vpc\_name](#output\_vpc\_name) | n/a |
| <a name="output_vpn_accesses"></a> [vpn\_accesses](#output\_vpn\_accesses) | n/a |
| <a name="output_vpn_gateway_arn"></a> [vpn\_gateway\_arn](#output\_vpn\_gateway\_arn) | n/a |
| <a name="output_vpn_gateway_id"></a> [vpn\_gateway\_id](#output\_vpn\_gateway\_id) | n/a |
