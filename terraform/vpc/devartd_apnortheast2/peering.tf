/*
resource "aws_vpc_peering_connection" "peering_connection" {
  for_each      = { for entry in var.vpc_peering_list : entry.peer_vpc_name => entry }
  peer_vpc_id   = each.value.peer_vpc_id
  peer_owner_id = each.value.peer_owner_id
  peer_region   = each.value.peer_region
  vpc_id        = aws_vpc.default.id

  tags = {
    Name          = "${var.shard_id}-with-${each.value.peer_vpc_name}"
    peer_vpc_name = each.value.peer_vpc_name
    Side          = "Requester"
  }
}
*/
