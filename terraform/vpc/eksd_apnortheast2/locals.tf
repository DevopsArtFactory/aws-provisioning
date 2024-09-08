resource "random_string" "suffix" {
  length  = 4
  numeric = false
  special = false
  upper   = false
}

locals {
  vpc_name         = replace("${var.product}${var.env_suffix}_${var.aws_region}", "-", "")
  shard_id         = var.shard_id
  eks_cluster_name = format("%s%s%s-%s", var.product, var.env_suffix, var.aws_short_region, random_string.suffix.result)

  private_subnet_peerings = flatten([
    for pair in setproduct(aws_route_table.private.*.id, var.peering_requests) : {
      route_table_id = pair[0]
      cidr_block     = pair[1].cidr_block
      vpc_name       = pair[1].vpc_name
      peering_id     = pair[1].id
    }
  ])

  private_db_subnet_peerings = flatten([
    for pair in setproduct(aws_route_table.private_db.*.id, var.db_peering_requests) : {
      route_table_id = pair[0]
      cidr_block     = pair[1].cidr_block
      vpc_name       = pair[1].vpc_name
      peering_id     = pair[1].id
    }
  ])
}
