##
# (c) 2021-2025
#     Cloud Ops Works LLC - https://cloudops.works/
#     Find us on:
#       GitHub: https://github.com/cloudopsworks
#       WebSite: https://cloudops.works
#     Distributed Under Apache v2.0 License
#
output "vpc_id" {
  value = module.vpc.vpc_id
}

output "vpc_cidr_block" {
  value = module.vpc.vpc_cidr_block
}

output "public_subnets" {
  value = module.vpc.public_subnets
}

output "private_subnets" {
  value = module.vpc.private_subnets
}

output "database_subnets" {
  value = module.vpc.database_subnets
}

output "ssh_admin_security_group_id" {
  value = aws_security_group.ssh_admin.id
}

output "bastion_security_group_id" {
  value = aws_security_group.bastion.id
}

output "database_subnet_group" {
  value = module.vpc.database_subnet_group
}

output "database_subnet_group_name" {
  value = module.vpc.database_subnet_group_name
}

output "nat_address" {
  value = tolist(module.vpc.nat_public_ips)
}

output "vpn_accesses" {
  value = var.vpn_accesses
}

output "private_route_table_ids" {
  value = module.vpc.private_route_table_ids
}

output "public_route_table_ids" {
  value = module.vpc.public_route_table_ids
}

output "database_route_table_ids" {
  value = module.vpc.database_route_table_ids
}

output "flowlogs_role_arn" {
  value = aws_iam_role.vpc_logs.arn
}

output "cloudwatch_log_group" {
  value = {
    name = aws_cloudwatch_log_group.log_group.name
    arn  = aws_cloudwatch_log_group.log_group.arn
  }
}

output "vpc_name" {
  value = "vpc-${local.system_name}"
}

output "intra_subnets" {
  value = module.vpc.intra_subnets
}

output "intra_route_table_ids" {
  value = module.vpc.intra_route_table_ids
}

output "vpn_gateway_id" {
  value = var.enable_vpn_gateway ? module.vpc.vgw_id : null
}

output "vpn_gateway_arn" {
  value = var.enable_vpn_gateway ? module.vpc.vgw_arn : null
}