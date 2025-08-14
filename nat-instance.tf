##
# (c) 2021-2025
#     Cloud Ops Works LLC - https://cloudops.works/
#     Find us on:
#       GitHub: https://github.com/cloudopsworks
#       WebSite: https://cloudops.works
#     Distributed Under Apache v2.0 License
#

data "aws_subnet" "alternat_subnet" {
  count = length(module.vpc.private_subnets)
  id    = module.vpc.private_subnets[count.index]
}

module "alternat_instances" {
  count               = var.high_volume_nat ? 1 : 0
  source              = "chime/alternat/aws"
  version             = "~> 0.9"
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
    for index, rt in module.vpc.private_route_table_ids : {
      az               = data.aws_subnet.alternat_subnet[index].availability_zone
      route_table_ids  = [rt]
      public_subnet_id = module.vpc.public_subnets[index]
      # The secondary subnets do not need to be included here. this data is
      # used for the connectivity test function and VPC endpoint which are
      # only needed in one subnet per zone.
      private_subnet_ids = [module.vpc.private_subnets[index]]
    }
  ]
  nat_instance_eip_ids = var.reuse_nat_ips ? var.external_nat_ip_ids : []
  depends_on           = [module.vpc]
}