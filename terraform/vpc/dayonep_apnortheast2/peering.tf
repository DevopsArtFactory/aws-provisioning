# Peering Connection Requester
resource "aws_vpc_peering_connection" "peerings" {
  count         = length(var.vpc_peerings)
  peer_vpc_id   = var.vpc_peerings[count.index]["peer_vpc_id"]
  peer_owner_id = var.vpc_peerings[count.index]["peer_owner_id"]
  peer_region   = var.vpc_peerings[count.index]["peer_region"]
  vpc_id        = aws_vpc.default.id

  tags = {
    Name          = "${var.shard_id}-with-${var.vpc_peerings[count.index]["peer_vpc_name"]}"
    peer_vpc_name = var.vpc_peerings[count.index]["peer_vpc_name"]
    Side          = "Requester"
  }
}
