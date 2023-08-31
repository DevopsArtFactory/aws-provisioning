resource "aws_eks_addon" "coredns" {
  cluster_name = aws_eks_cluster.eks_cluster.name

  addon_name    = "coredns"
  addon_version = var.coredns_version

  configuration_values = var.configuration_values

  resolve_conflicts = "OVERWRITE"
  depends_on = [
    aws_eks_node_group.eks_node_group,
  ]
}

resource "aws_eks_addon" "kube_proxy" {
  cluster_name  = aws_eks_cluster.eks_cluster.name
  addon_name    = "kube-proxy"
  addon_version = var.kube_proxy_version

  resolve_conflicts = "OVERWRITE"
  depends_on = [
    aws_eks_node_group.eks_node_group,
  ]
}

resource "aws_eks_addon" "vpc_cni" {
  cluster_name = aws_eks_cluster.eks_cluster.name

  addon_name    = "vpc-cni"
  addon_version = var.vpc_cni_version

  service_account_role_arn = aws_iam_role.cni_irsa_role.arn
  resolve_conflicts        = "OVERWRITE"
  depends_on = [
    aws_eks_node_group.eks_node_group,
  ]
}

resource "aws_eks_addon" "aws_ebs_csi_driver" {
  cluster_name = aws_eks_cluster.eks_cluster.name

  addon_name    = "aws-ebs-csi-driver"
  addon_version = var.aws_ebs_csi_driver_version

  resolve_conflicts = "OVERWRITE"
  depends_on = [
    aws_eks_node_group.eks_node_group,
  ]
}

resource "aws_iam_role" "cni_irsa_role" {
  name        = "eks-${var.cluster_name}-cni-plugin"
  description = "CNI plugin role for EKS cluster ${var.cluster_name}"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Federated": "${local.openid_connect_provider_id}"
      },
      "Action": "sts:AssumeRoleWithWebIdentity",
      "Condition": {
        "StringEquals": {
          "${local.openid_connect_provider_url}:sub": "system:serviceaccount:kube-system:aws-node"
        }
      }
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "cni_irsa_policy" {
  role       = aws_iam_role.cni_irsa_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}
