resource "random_string" "suffix" {
  length  = 4
  numeric = false
  special = false
  upper   = false
}

locals {
  vpc_name         = replace("${var.product}${var.env_suffix}_${var.aws_region}", "-", "")
  shard_id         = "${var.product}${var.env_suffix}${var.aws_short_region}"
  eks_cluster_name = format("%s%s%s-%s", var.product, var.env_suffix, var.aws_short_region, random_string.suffix.result)
}
