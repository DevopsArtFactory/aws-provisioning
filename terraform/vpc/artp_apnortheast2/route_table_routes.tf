locals {
  peering_list = flatten([
    for key in var.vpc_peering_list : [
      for i, v in var.availability_zones_without_b : {
        peer_vpc_id   = key.peer_vpc_id
        peer_owner_id = key.peer_owner_id
        peer_region   = key.peer_region
        peer_vpc_name = key.peer_vpc_name
        vpc_cidr      = key.vpc_cidr
        zone_idx      = i
      }
    ]
  ])

  peering_map = {
    for obj in local.peering_list : "${obj.peer_vpc_name}_${obj.zone_idx}" => obj
  }
}

# Routes for internet gateway which will be set in public subent
resource "aws_route" "public_internet_gateway" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.default.id
}

# Routes for NAT gateway which will be set in private subent
resource "aws_route" "private_nat" {
  count                  = length(var.availability_zones_without_b)
  route_table_id         = element(aws_route_table.private.*.id, count.index)
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = element(aws_nat_gateway.nat.*.id, count.index)
}

# Routes for public subnet with peering connection
resource "aws_route" "public" {
  for_each                  = var.vpc_peering_list
  route_table_id            = aws_route_table.public.id
  destination_cidr_block    = each.value.vpc_cidr
  vpc_peering_connection_id = aws_vpc_peering_connection.peering_connection[each.value.peer_vpc_name].id
}

# Routes for private subnet with peering connection
resource "aws_route" "private_peering" {
  for_each                  = local.peering_map
  route_table_id            = aws_route_table.private[each.value.zone_idx].id
  destination_cidr_block    = each.value.vpc_cidr
  vpc_peering_connection_id = aws_vpc_peering_connection.peering_connection[each.value.peer_vpc_name].id
}
