##
# (c) 2021-2025
#     Cloud Ops Works LLC - https://cloudops.works/
#     Find us on:
#       GitHub: https://github.com/cloudopsworks
#       WebSite: https://cloudops.works
#     Distributed Under Apache v2.0 License
#

# Secrets saving
resource "aws_secretsmanager_secret" "bastion_public_key" {
  count = var.create_bastion && var.secrets_manager_enabled ? 1 : 0
  name  = "${local.secret_store_path}/vpc/bastion-${local.system_name}/public-key"
  tags  = local.all_tags
}

resource "aws_secretsmanager_secret_version" "bastion_public_key" {
  count         = var.create_bastion && var.secrets_manager_enabled ? 1 : 0
  secret_id     = aws_secretsmanager_secret.bastion_public_key[count.index].id
  secret_string = aws_key_pair.bastion_key[count.index].public_key
}

resource "aws_secretsmanager_secret" "bastion_private_key" {
  count = var.create_bastion && var.secrets_manager_enabled ? 1 : 0
  name  = "${local.secret_store_path}/vpc/bastion-${local.system_name}/private-key"
  tags  = local.all_tags
}

resource "aws_secretsmanager_secret_version" "bastion_private_key" {
  count         = var.create_bastion && var.secrets_manager_enabled ? 1 : 0
  secret_id     = aws_secretsmanager_secret.bastion_private_key[count.index].id
  secret_string = tls_private_key.keypair_gen_bastion[count.index].private_key_pem
}

resource "aws_ssm_parameter" "tronador_accelerate_bastion_key" {
  count = var.create_bastion && var.secrets_manager_enabled && var.devops_accelerator ? 1 : 0
  name  = "/cloudopsworks/tronador/bastion/${var.spoke_def}/key-secret-name"
  type  = "String"
  value = aws_secretsmanager_secret.bastion_private_key[0].name
}

resource "aws_ssm_parameter" "tronador_accelerate_bastion_instance" {
  count = var.create_bastion && var.secrets_manager_enabled && var.devops_accelerator ? 1 : 0
  name  = "/cloudopsworks/tronador/bastion/${var.spoke_def}/instance-id"
  type  = "String"
  value = aws_instance.bastion_server[0].id
}

resource "aws_ssm_parameter" "tronador_accelerate_bastion_instance_sg" {
  count = var.create_bastion && var.secrets_manager_enabled && var.devops_accelerator ? 1 : 0
  name  = "/cloudopsworks/tronador/bastion/${var.spoke_def}/security-group-id"
  type  = "String"
  value = aws_security_group.bastion.id
}
