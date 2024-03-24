/*
locals {
  private_peering_route_list = flatten([
    for pair in setproduct(var.vpc_peering_list, aws_route_table.private.*.id) : [
      for cidr in pair[0].vpc_cidrs : {
        peer_vpc_name  = pair[0].peer_vpc_name
        vpc_cidr       = cidr
        route_table_id = pair[1]
      }
    ]
  ])
}

resource "aws_route" "private_peering_with_request" {
  for_each                  = { for entry in local.private_peering_route_list : "${entry.peer_vpc_name}_${entry.vpc_cidr}_${entry.route_table_id}" => entry }
  route_table_id            = each.value.route_table_id
  destination_cidr_block    = each.value.vpc_cidr
  vpc_peering_connection_id = aws_vpc_peering_connection.peering_connection[each.value.peer_vpc_name].id
}
*/
