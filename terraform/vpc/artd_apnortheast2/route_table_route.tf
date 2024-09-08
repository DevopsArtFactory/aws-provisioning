resource "aws_route" "public_internet_gateway" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.default.id
}

resource "aws_route" "private_nat" {
  count                  = length(var.availability_zones)
  route_table_id         = aws_route_table.private[count.index].id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.nat[count.index].id
}

resource "aws_route" "private_peering" {
  for_each                  = { for entry in local.private_subnet_peerings : "${entry.vpc_name}_${entry.route_table_id}" => entry }
  route_table_id            = each.value.route_table_id
  destination_cidr_block    = each.value.cidr_block
  vpc_peering_connection_id = each.value.peering_id
}

resource "aws_route" "privatedb_peering" {
  for_each                  = { for entry in local.private_db_subnet_peerings : "${entry.vpc_name}_${entry.route_table_id}" => entry }
  route_table_id            = each.value.route_table_id
  destination_cidr_block    = each.value.cidr_block
  vpc_peering_connection_id = each.value.peering_id
}