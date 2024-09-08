locals {
  openid_connect_provider_id  = aws_iam_openid_connect_provider.eks.arn
  openid_connect_provider_url = replace(aws_iam_openid_connect_provider.eks.url, "https://", "")
}

data "tls_certificate" "oidc" {
  url = aws_eks_cluster.eks_cluster.identity[0].oidc[0].issuer
}

resource "aws_iam_openid_connect_provider" "eks" {
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [data.tls_certificate.oidc.certificates[0].sha1_fingerprint]
  url             = aws_eks_cluster.eks_cluster.identity[0].oidc[0].issuer
}
