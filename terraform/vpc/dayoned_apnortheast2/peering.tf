resource "aws_vpc_peering_connection_accepter" "dayonep_apnortheast2" {
  vpc_peering_connection_id = var.vpc_peer_connection_id_dayonep_apne2
  auto_accept               = true
}

