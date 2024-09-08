output "aws_security_group_eks_cluster_default_id" {
  description = "Default Security Group for EKS cluster"
  value       = module.eks.aws_security_group_cluster_default_id
}

output "aws_security_group_eks_cluster_id" {
  description = "Security Group for EKS cluster"
  value       = module.eks.aws_security_group_cluster_id
}

output "aws_security_group_eks_node_group_id" {
  description = "Security Group for EKS node group"
  value       = module.eks.aws_security_group_node_group_id
}

output "aws_iam_openid_connect_provider_arn" {
  description = "IAM OpenId Connect Provider ARN for EKS"
  value       = module.eks.aws_iam_openid_connect_provider_arn
}

output "aws_iam_openid_connect_provider_url" {
  description = "IAM OpenId Connect Provider URL for EKS"
  value       = module.eks.aws_iam_openid_connect_provider_url
}
