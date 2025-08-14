##
# (c) 2021-2025
#     Cloud Ops Works LLC - https://cloudops.works/
#     Find us on:
#       GitHub: https://github.com/cloudopsworks
#       WebSite: https://cloudops.works
#     Distributed Under Apache v2.0 License
#

module "nat_instance" {
  count                       = local.use_nat_instance ? 1 : 0
  source                      = "git::https://github.com/cloudopsworks/terraform-aws-nat-instance.git//?ref=v0.1.0-beta.2"
  name                        = "nat-instance-${local.system_name}"
  vpc_id                      = module.vpc.vpc_id
  public_subnet               = element(module.vpc.public_subnets, 0)
  private_subnets_cidr_blocks = module.vpc.private_subnets_cidr_blocks
  private_route_table_ids     = module.vpc.private_route_table_ids
}

resource "aws_eip" "nat_ec2_instance" {
  count             = local.use_nat_instance ? 1 : 0
  network_interface = module.nat_instance[0].eni_id
  tags = merge(local.all_tags, {
    Name = "nat-instance-eip-${local.system_name}"
  })
}
