# routes for internet gateway which will be set in public subent
resource "aws_route" "public_internet_gateway" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.default.id
}

## routes for NAT gateway which will be set in private subent
resource "aws_route" "private_nat" {
  count                  = length(var.availability_zones)
  route_table_id         = element(aws_route_table.private.*.id, count.index)
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = element(aws_nat_gateway.nat.*.id, count.index)
}

# Peering in public route table
resource "aws_route" "artp_public_peering" {
  route_table_id            = aws_route_table.public.id
  destination_cidr_block    = var.artp_destination_cidr_block
  vpc_peering_connection_id = var.vpc_peer_connection_id_artp_apne2
}

# Peering in private route table
resource "aws_route" "artp_private_peering" {
  count                     = length(var.availability_zones)
  route_table_id            = element(aws_route_table.private.*.id, count.index)
  destination_cidr_block    = var.artp_destination_cidr_block
  vpc_peering_connection_id = var.vpc_peer_connection_id_artp_apne2
}
