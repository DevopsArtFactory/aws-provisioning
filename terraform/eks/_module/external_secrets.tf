resource "aws_iam_role" "external_secrets" {
  name               = "eks-${var.cluster_name}-external-secrets"
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
          "${local.openid_connect_provider_url}:sub": "system:serviceaccount:external-secrets:external-secrets"
        }
      }
    }
  ]
}
POLICY
}

# IAM Policy
resource "aws_iam_policy" "external_secrets" {
  name   = "eks-${var.cluster_name}-external-secrets"
  policy = <<-EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "ssm:GetParameter",
      "Resource": "*",
      "Condition": {
        "ForAllValues:StringEquals": {
          "aws:ResourceTag/kubernetes.io/cluster/${var.cluster_name}": [
            "owned",
            "shared"
          ]      
        }
      }
    },
    {
      "Effect": "Allow",
      "Action": [
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
        "kms:DescribeKey",
        "ssm:GetParameterHistory",
        "ssm:GetParameters",
        "ssm:GetParameter",
        "ssm:DescribeParameters",
        "ssm:GetParametersByPath",
        "secretsmanager:ListSecrets",
        "secretsmanager:GetResourcePolicy",
        "secretsmanager:GetSecretValue",
        "secretsmanager:DescribeSecret",
        "secretsmanager:ListSecretVersionIds"
      ],
      "Resource": "*",
      "Condition": {
        "ForAllValues:StringEquals": {
          "aws:ResourceTag/kubernetes.io/cluster/${var.cluster_name}": [
            "owned",
            "shared"
          ]      
        }
      }
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "external_secrets" {
  policy_arn = aws_iam_policy.external_secrets.arn
  role       = aws_iam_role.external_secrets.name
}
