##
# (c) 2021-2025
#     Cloud Ops Works LLC - https://cloudops.works/
#     Find us on:
#       GitHub: https://github.com/cloudopsworks
#       WebSite: https://cloudops.works
#     Distributed Under Apache v2.0 License
#
output "bastion_key" {
  value = tls_private_key.keypair_gen_bastion.*.public_key_openssh
}

output "bastion_public_address" {
  value = aws_instance.bastion_server.*.public_dns
}

output "bastion_public_ip" {
  value = aws_instance.bastion_server.*.public_ip
}

output "bastion_ssm_parameter" {
  value = var.create_bastion && var.secrets_manager_enabled && var.devops_accelerator ? aws_ssm_parameter.tronador_accelerate_bastion_instance[0].name : null
}

output "bastion_ssm_parameter_user" {
  value = var.create_bastion && var.secrets_manager_enabled && var.devops_accelerator ? aws_ssm_parameter.tronador_accelerate_bastion_instance_user[0].name : null
}

output "bastion_ssm_parameter_bastion_key" {
  value = var.create_bastion && var.secrets_manager_enabled && var.devops_accelerator ? aws_ssm_parameter.tronador_accelerate_bastion_key[0].name : null
}

output "bastion_private_key_secret" {
  value = var.create_bastion && var.secrets_manager_enabled ? aws_secretsmanager_secret.bastion_private_key[0].name : null
}

output "bastion_private_key_secret_arn" {
  value = var.create_bastion && var.secrets_manager_enabled ? aws_secretsmanager_secret.bastion_private_key[0].arn : null
}