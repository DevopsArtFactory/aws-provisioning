resource "aws_iam_role" "external_secrets" {
  name = "eks-${var.cluster_name}-external-secrets"
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Federated" : "${local.openid_connect_provider_id}"
        },
        "Action" : "sts:AssumeRoleWithWebIdentity",
        "Condition" : {
          "StringEquals" : {
            "${local.openid_connect_provider_url}:sub" : "system:serviceaccount:external-secrets:external-secrets"
          }
        }
      }
    ]
  })
}

# IAM Policy
resource "aws_iam_policy" "external_secrets" {
  name = "eks-${var.cluster_name}-external-secrets"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "kms:GetPublicKey",
          "kms:Decrypt",
          "kms:ListKeyPolicies",
          "kms:ListRetirableGrants",
          "kms:GetKeyPolicy",
          "kms:ListResourceTags",
          "kms:ListGrants",
          "kms:GetParametersForImport",
          "kms:DescribeCustomKeyStores",
          "kms:ListKeys",
          "kms:GetKeyRotationStatus",
          "kms:Encrypt",
          "kms:ListAliases",
          "kms:DescribeKey"
        ],
        Resource = var.external_secrets_access_kms_arns,
        Condition = {
          "ForAllValues:StringEquals" = {
            "aws:ResourceTag/kubernetes.io/cluster/${var.cluster_name}" = ["owned", "shared"]
          }
        }
      },
      {
        Effect = "Allow",
        Action = [
          "ssm:GetParameterHistory",
          "ssm:GetParameters",
          "ssm:GetParameter",
          "ssm:DescribeParameters",
          "ssm:GetParametersByPath"
        ],
        Resource = var.external_secrets_access_ssm_arns,
        Condition = {
          "ForAllValues:StringEquals" = {
            "aws:ResourceTag/kubernetes.io/cluster/${var.cluster_name}" = ["owned", "shared"]
          }
        }
      },
      {
        Effect = "Allow",
        Action = [
          "secretsmanager:ListSecrets",
          "secretsmanager:GetResourcePolicy",
          "secretsmanager:GetSecretValue",
          "secretsmanager:DescribeSecret",
          "secretsmanager:ListSecretVersionIds"
        ],
        Resource = var.external_secrets_access_secretsmanager_arns,
        Condition = {
          "ForAllValues:StringEquals" = {
            "aws:ResourceTag/kubernetes.io/cluster/${var.cluster_name}" = ["owned", "shared"]
          }
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "external_secrets" {
  policy_arn = aws_iam_policy.external_secrets.arn
  role       = aws_iam_role.external_secrets.name
}
