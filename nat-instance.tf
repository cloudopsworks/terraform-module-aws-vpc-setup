##
# (c) 2021-2025
#     Cloud Ops Works LLC - https://cloudops.works/
#     Find us on:
#       GitHub: https://github.com/cloudopsworks
#       WebSite: https://cloudops.works
#     Distributed Under Apache v2.0 License
#
module "alternat_instances" {
  source              = "chime/alternat/aws"
  version             = "~> 0.9"
  create_nat_gateways = local.use_nat_instance
  lambda_package_type = "Zip"
  nat_instance_block_devices = {
    xvda = {
      device_name = "/dev/xvda"
      ebs = {
        encrypted   = true
        volume_type = "gp3"
        volume_size = 8
      }
    }
  }
  vpc_id                                = module.vpc.vpc_id
  ingress_security_group_ids            = [aws_security_group.ssh_admin.id, aws_security_group.bastion.id]
  nat_instance_iam_profile_name         = "nat-instance-${local.system_name}"
  nat_instance_iam_role_name            = "nat-instance-${local.system_name}"
  nat_instance_lifecycle_hook_role_name = "nat-lifecycle-hook-${local.system_name}"
  nat_instance_name_prefix              = "nat-instance-${local.system_name_short}"
  nat_instance_sg_name_prefix           = "nat-instance-${local.system_name_short}"
  nat_lambda_function_role_name         = "nat-lambda-${local.system_name_short}"
  nat_instance_type                     = var.nat_instance_size
  tags                                  = local.all_tags
  vpc_az_maps = [
    {
      az                 = var.availability_zones[0]
      private_subnet_ids = concat(module.vpc.private_subnets, module.vpc.database_subnets)
      public_subnet_id   = module.vpc.public_subnets[0]
      route_table_ids    = concat(module.vpc.private_route_table_ids, module.vpc.database_route_table_ids)
    },
  ]
  nat_instance_eip_ids = var.reuse_nat_ips ? var.external_nat_ip_ids : []
  depends_on           = [module.vpc]
}