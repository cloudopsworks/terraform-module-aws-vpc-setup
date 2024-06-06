##
# (c) 2024 - Cloud Ops Works LLC - https://cloudops.works/
#            On GitHub: https://github.com/cloudopsworks
#            Distributed Under Apache v2.0 License
#
output "vpc_id" {
  value = module.vpc.vpc_id
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

output "nat_address" {
  value = tolist(module.vpc.nat_public_ips)
}

output "vpn_accesses" {
  value = var.vpn_accesses
}

output "private_route_table_ids" {
  value = module.vpc.private_route_table_ids
}