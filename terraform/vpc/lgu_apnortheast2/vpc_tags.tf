locals {
  vpc_tags = {
    "kubernetes.io/cluster/${local.eks_cluster_name}" : "owned",
    "Name" : "vpc-${local.vpc_name}"
  }
  public_subnets_tags = {
    "kubernetes.io/cluster/${local.eks_cluster_name}" : "shared"
    "kubernetes.io/role/elb" : 1
  }

  private_subnets_tags = {
    Network = "Private"
    "kubernetes.io/cluster/${local.eks_cluster_name}" : "shared"
    "kubernetes.io/role/internal-elb" : 1
    "karpenter.sh/discovery" : "${local.eks_cluster_name}"
  }

  public_subnets_tags_flat = distinct(flatten([
    for id in aws_subnet.public.*.id : [
      for key, value in local.public_subnets_tags : {
        id    = id
        key   = key
        value = value
      }
    ]
  ]))
  private_subnets_tags_flat = distinct(flatten([
    for id in aws_subnet.private.*.id : [
      for key, value in local.private_subnets_tags : {
        id    = id
        key   = key
        value = value
      }
    ]
  ]))
}

resource "aws_ec2_tag" "vpc_tags" {
  for_each    = local.vpc_tags
  resource_id = aws_vpc.default.id
  key         = each.key
  value       = each.value
}

resource "aws_ec2_tag" "public_subnet_tags" {
  for_each    = { for entry in local.public_subnets_tags_flat : "${entry.id}_${entry.key}" => entry }
  resource_id = each.value.id
  key         = each.value.key
  value       = each.value.value
}

resource "aws_ec2_tag" "private_subnet_tags" {
  for_each    = { for entry in local.private_subnets_tags_flat : "${entry.id}_${entry.key}" => entry }
  resource_id = each.value.id
  key         = each.value.key
  value       = each.value.value
}
