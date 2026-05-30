resource "aws_iam_openid_connect_provider" "teamjupiter_vercel" {
  url = "https://oidc.vercel.com/${var.teamjupiter_vercel_team_slug}"

  client_id_list = [
    "https://vercel.com/${var.teamjupiter_vercel_team_slug}"
  ]

  thumbprint_list = var.teamjupiter_vercel_oidc_thumbprint_list
}

locals {
  teamjupiter_vercel_oidc_subjects = flatten([
    for project_name in var.teamjupiter_vercel_project_names : [
      for environment in var.teamjupiter_vercel_environments :
      "owner:${var.teamjupiter_vercel_team_slug}:project:${project_name}:environment:${environment}"
    ]
  ])
}

data "aws_iam_policy_document" "teamjupiter_vercel_assume_role_document" {
  statement {
    effect = "Allow"

    principals {
      type = "Federated"
      identifiers = [
        aws_iam_openid_connect_provider.teamjupiter_vercel.arn
      ]
    }

    condition {
      test     = "StringEquals"
      variable = "oidc.vercel.com/${var.teamjupiter_vercel_team_slug}:aud"
      values = [
        "https://vercel.com/${var.teamjupiter_vercel_team_slug}"
      ]
    }

    condition {
      test     = "StringEquals"
      variable = "oidc.vercel.com/${var.teamjupiter_vercel_team_slug}:sub"
      values   = local.teamjupiter_vercel_oidc_subjects
    }

    actions = ["sts:AssumeRoleWithWebIdentity"]
  }
}

resource "aws_iam_role" "teamjupiter_vercel_download" {
  name               = "teamjupiter-vercel-download"
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.teamjupiter_vercel_assume_role_document.json

  tags = {
    Name    = "teamjupiter-vercel-download"
    app     = "teamjupiter"
    project = "teamjupiter"
    service = "download-request"
    env     = "prod"
  }
}

data "aws_iam_policy_document" "teamjupiter_vercel_download" {
  statement {
    sid    = "AllowDownloadRequestWrites"
    effect = "Allow"

    actions = [
      "dynamodb:PutItem"
    ]

    resources = [
      "arn:aws:dynamodb:${var.teamjupiter_aws_region}:${var.account_id.id}:table/${var.teamjupiter_download_requests_table_name}"
    ]
  }

  statement {
    sid    = "AllowPresignedDownloadReads"
    effect = "Allow"

    actions = [
      "s3:GetObject"
    ]

    resources = [
      for prefix in var.teamjupiter_download_object_prefixes :
      "arn:aws:s3:::${var.teamjupiter_downloads_bucket_name}/${prefix}*"
    ]
  }
}

resource "aws_iam_role_policy" "teamjupiter_vercel_download" {
  name   = "teamjupiter-vercel-download"
  role   = aws_iam_role.teamjupiter_vercel_download.id
  policy = data.aws_iam_policy_document.teamjupiter_vercel_download.json
}

output "teamjupiter_vercel_download_role_arn" {
  value = aws_iam_role.teamjupiter_vercel_download.arn
}
