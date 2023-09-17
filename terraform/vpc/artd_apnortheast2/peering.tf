#resource "aws_vpc_peering_connection_accepter" "artp_apnortheast2" {
#  vpc_peering_connection_id = var.vpc_peer_connection_id_artp_apne2
#  auto_accept               = true
#}
#

# Peering in public route table
#resource "aws_route" "artp_public_peering" {
#  route_table_id            = aws_route_table.public.id
#  destination_cidr_block    = var.artp_destination_cidr_block
#  vpc_peering_connection_id = var.vpc_peer_connection_id_artp_apne2
#}
#
## Peering in private route table
#resource "aws_route" "artp_private_peering" {
#  count                     = length(var.availability_zones)
#  route_table_id            = element(aws_route_table.private.*.id, count.index)
#  destination_cidr_block    = var.artp_destination_cidr_block
#  vpc_peering_connection_id = var.vpc_peer_connection_id_artp_apne2
#}
