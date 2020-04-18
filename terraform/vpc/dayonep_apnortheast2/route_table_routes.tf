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
resource "aws_route" "public_peering" {
  count                     = length(var.vpc_peerings)
  route_table_id            = aws_route_table.public.id
  destination_cidr_block    = var.vpc_peerings[count.index]["vpc_cidr"]
  vpc_peering_connection_id = element(aws_vpc_peering_connection.peerings.*.id, count.index)
}

# Routes for private subnet with peering connection
resource "aws_route" "private_peering" {
  count = length(var.vpc_peerings) * length(var.availability_zones_without_b)
  route_table_id = element(
    aws_route_table.private.*.id,
    floor(count.index / length(var.vpc_peerings))
  )
  destination_cidr_block = var.vpc_peerings[count.index % length(var.vpc_peerings)]["vpc_cidr"]
  vpc_peering_connection_id = element(
    aws_vpc_peering_connection.peerings.*.id,
    count.index % length(var.vpc_peerings)
  )
}
