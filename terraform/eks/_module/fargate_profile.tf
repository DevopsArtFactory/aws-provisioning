resource "aws_eks_fargate_profile" "this" {
  count = var.fargate_enable ? 1 : 0

  cluster_name           = var.cluster_name
  fargate_profile_name   = var.fargate_profile_name
  pod_execution_role_arn = aws_iam_role.eks_fargate[0].arn
  subnet_ids             = var.private_subnets

  dynamic "selector" {
    for_each = var.selectors

    content {
      namespace = selector.value.namespace
      labels    = lookup(selector.value, "labels", {})
    }
  }

  dynamic "timeouts" {
    for_each = [var.timeouts]
    content {
      create = lookup(var.timeouts, "create", null)
      delete = lookup(var.timeouts, "delete", null)
    }
  }

  tags = var.tags
}

resource "aws_iam_role" "eks_fargate" {
  count = var.fargate_enable ? 1 : 0
  name  = "eks-${var.fargate_profile_name}"

  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Service" : [
            "eks-fargate-pods.amazonaws.com"
          ]
        },
        "Action" : "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy" "eks-fargate-logging-policy" {
  count = var.fargate_enable ? 1 : 0
  name  = "eks-${var.fargate_profile_name}"

  role = aws_iam_role.eks_fargate[0].id
  policy = jsonencode({
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : [
          "logs:CreateLogStream",
          "logs:CreateLogGroup",
          "logs:DescribeLogStreams",
          "logs:PutLogEvents"
        ],
        "Resource" : "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "eks_fargate_AmazonEKSFargatePodExecutionRolePolicy" {
  for_each   = var.fargate_enable ? toset(concat(["arn:aws:iam::aws:policy/AmazonEKSFargatePodExecutionRolePolicy"], var.iam_role_additional_policies)) : toset([])
  policy_arn = each.value
  role       = aws_iam_role.eks_fargate[0].name
}
