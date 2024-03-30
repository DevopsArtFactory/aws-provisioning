/*
locals {
  private_subnet_peerings = flatten([
    for pair in setproduct(aws_route_table.private.*.id, var.peering_requests) : {
      route_table_id = pair[0]
      cidr_block     = pair[1].cidr_block
      vpc_name       = pair[1].vpc_name
      peering_id     = pair[1].id
    }
  ])
}

resource "aws_route" "private_peering" {
  for_each                  = { for entry in local.private_subnet_peerings : "${entry.vpc_name}_${entry.route_table_id}" => entry }
  route_table_id            = each.value.route_table_id
  destination_cidr_block    = each.value.cidr_block
  vpc_peering_connection_id = each.value.peering_id
}
*/
