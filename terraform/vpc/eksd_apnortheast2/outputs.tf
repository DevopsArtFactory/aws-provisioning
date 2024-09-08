output "aws_region" {
  value = var.aws_region
}

output "region_namespace" {
  value = replace(var.aws_region, "-", "")
}

output "vpc_name" {
  description = "The name of the VPC which is also the environment name"
  value       = local.vpc_name
}

output "eks_cluster_name" {
  value = local.eks_cluster_name
}

output "shard_id" {
  description = "The name of the VPC which is also the environment name"
  value       = local.shard_id
}

output "env_suffix" {
  description = "The name of the VPC which is also the environment name"
  value       = var.env_suffix
}

output "billing_tag" {
  description = "The env for biliing consolidation."
  value       = var.billing_tag
}

output "vpc_id" {
  value = aws_vpc.default.id
}

output "cidr_block" {
  value = aws_vpc.default.cidr_block
}

output "cidr_numeral" {
  value = var.cidr_numeral
}

# Availability_zones
output "availability_zones" {
  value = var.availability_zones
}

# Prviate subnets
output "private_subnets" {
  value = aws_subnet.private.*.id
}

# Public subnets
output "public_subnets" {
  value = aws_subnet.public.*.id
}

# Private Database Subnets
output "db_private_subnets" {
  value = aws_subnet.private_db.*.id
}

output "aws_private_db_cidr_blocks" {
  value = aws_subnet.private_db.*.cidr_block
}

# Misc
output "route53_internal_zone_id" {
  value = aws_route53_zone.internal.zone_id
}

output "route53_internal_domain" {
  value = aws_route53_zone.internal.name
}

