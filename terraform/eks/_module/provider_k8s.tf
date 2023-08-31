locals {
  role_args = length(var.assume_role_arn) > 0 ? ["--role-arn", var.assume_role_arn] : []
}

provider "kubernetes" {
  host                   = aws_eks_cluster.eks_cluster.endpoint
  cluster_ca_certificate = base64decode(aws_eks_cluster.eks_cluster.certificate_authority[0].data)
  exec {
    api_version = "client.authentication.k8s.io/v1"
    args        = concat(["eks", "get-token", "--cluster-name", var.cluster_name], local.role_args)
    command     = "aws"
  }
}
