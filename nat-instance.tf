##
# (c) 2021-2025
#     Cloud Ops Works LLC - https://cloudops.works/
#     Find us on:
#       GitHub: https://github.com/cloudopsworks
#       WebSite: https://cloudops.works
#     Distributed Under Apache v2.0 License
#

module "nat_instance" {
  count                = local.use_nat_instance ? 1 : 0
  source               = "git::https://github.com/cloudopsworks/terraform-aws-fck-nat.git//?ref=main"
  name                 = "nat-instance-${local.system_name}"
  vpc_id               = module.vpc.vpc_id
  subnet_id            = element(module.vpc.public_subnets, 0)
  eip_allocation_ids   = [aws_eip.nat_ec2_instance[0].id]
  use_cloudwatch_agent = true
  update_route_tables  = true
  instance_type        = var.nat_instance_size
  route_tables_ids = merge({
    for rtb in module.vpc.private_route_table_ids : "private-${rtb}" => rtb
    }, {
    for rtb in module.vpc.intra_route_table_ids : "intra-${rtb}" => rtb
    }, {
    for rtb in module.vpc.database_route_table_ids : "db-${rtb}" => rtb
    }
  )
  tags = local.all_tags
}

resource "aws_eip" "nat_ec2_instance" {
  count             = local.use_nat_instance ? 1 : 0
  tags = merge(local.all_tags, {
    Name = "nat-instance-eip-${local.system_name}"
  })
}
