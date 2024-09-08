provider "aws" {
  region = "ap-northeast-2"

  assume_role {
    role_arn     = var.assume_role_arn
    session_name = var.atlantis_user
  }
}

provider "kubernetes" {
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
  exec {
    api_version = "client.authentication.k8s.io/v1"
    args        = concat(["eks", "get-token", "--cluster-name", local.cluster_name], local.role_args)
    command     = "aws"
  }
}