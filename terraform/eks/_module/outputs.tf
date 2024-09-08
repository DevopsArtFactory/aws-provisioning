output "aws_security_group_cluster_default_id" {
  description = "EKS cluster default security group"
  value       = aws_eks_cluster.eks_cluster.vpc_config[0].cluster_security_group_id
}

output "aws_security_group_cluster_id" {
  description = "EKS cluster security group"
  value       = aws_security_group.eks_cluster.id
}

output "aws_security_group_node_group_id" {
  description = "EKS node group security group"
  value       = aws_security_group.eks_node_group.id
}

output "aws_iam_openid_connect_provider_arn" {
  description = "IAM OpenId Connect Provider ARN for EKS"
  value       = aws_iam_openid_connect_provider.eks.arn
}

output "aws_iam_openid_connect_provider_url" {
  description = "IAM OpenId Connect Provider URL for EKS"
  value       = aws_iam_openid_connect_provider.eks.url
}


output "cluster_endpoint" {
  description = "EKS Cluster API Endpoint"
  value       = aws_eks_cluster.eks_cluster.endpoint
}

output "cluster_certificate_authority_data" {
  description = "EKS Cluster CA(certificate authority) data"
  value       = aws_eks_cluster.eks_cluster.certificate_authority[0].data
}