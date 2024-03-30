/*
resource "aws_vpc_peering_connection_accepter" "peering_accepter" {
  for_each                  = { for entry in var.peering_requests : entry.id => entry }
  vpc_peering_connection_id = each.value.id
  auto_accept               = true
  tags = {
    Name = "vpc-peering-${var.shard_id}-with-${each.value.vpc_name}"
  }

  lifecycle {
    ignore_changes = [tags]
  }
}
*/
