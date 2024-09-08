resource "aws_iam_role" "gitaction" {
  name               = "gitaction"
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.gitaction_assume_role_document.json
}

data "aws_iam_policy_document" "gitaction_assume_role_document" {
  statement {
    effect = "Allow"

    principals {
      type = "Federated"
      identifiers = [
        "arn:aws:iam::${var.account_id.id}:oidc-provider/token.actions.githubusercontent.com"
      ]
    }

    condition {
      test     = "StringEquals"
      variable = "token.actions.githubusercontent.com:aud"
      values = [
        "sts.amazonaws.com"
      ]
    }

    condition {
      test     = "StringLike"
      variable = "token.actions.githubusercontent.com:sub"
      values = [
        "repo:DevopsArtFactory/*:*",
      ]
    }

    actions = ["sts:AssumeRoleWithWebIdentity", ]
  }
}

resource "aws_iam_role_policy" "gitaction_ecr" {
  name   = "gitaction-ecr"
  role   = aws_iam_role.gitaction.id
  policy = data.aws_iam_policy_document.gitaction_ecr.json

}

data "aws_iam_policy_document" "gitaction_ecr" {
  statement {
    sid       = "AllowGetAuthTokenAccess"
    effect    = "Allow"
    actions   = ["ecr:GetAuthorizationToken"]
    resources = ["*"]
  }

  statement {
    sid    = "AllowReadECRAccess"
    effect = "Allow"
    actions = [
      "ecr:BatchCheckLayerAvailability",
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage",
      "ecr:PutImage",
      "ecr:InitiateLayerUpload",
      "ecr:UploadLayerPart",
      "ecr:CompleteLayerUpload"
    ]
    resources = ["*"]
  }
}

output "gitaction_arn" {
  value = aws_iam_role.gitaction.arn
}
