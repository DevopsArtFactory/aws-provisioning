locals {
  openid_connect_provider_id  = aws_iam_openid_connect_provider.eks.arn
  openid_connect_provider_url = replace(aws_iam_openid_connect_provider.eks.url, "https://", "")
}

resource "aws_iam_openid_connect_provider" "eks" {
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = ["9e99a48a9960b14926bb7f3b02e22da2b0ab7280"]
  url             = aws_eks_cluster.eks_cluster.identity[0].oidc[0].issuer
}
