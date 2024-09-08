
resource "aws_kms_key" "common" {
  description         = "KMS key for encrypt with sops the ${replace(replace(var.common_alias, "-", " "), "_", " ")} secrets in ${var.region}."
  enable_key_rotation = true
  policy = jsonencode({
    Version : "2012-10-17"
    Id : "key-common-1"
    Statement : [
      {
        Effect : "Allow",
        Principal : {
          AWS : var.common_aliow_arns.manage
        },
        Action : "kms:*",
        Resource : "*"
      },
      {
        Sid : "Enable IAM Application Permissions",
        Effect : "Allow",
        Principal : {
          AWS : var.common_aliow_arns.use
        },
        Action : [
          "kms:Encrypt",
          "kms:Decrypt",
          "kms:ReEncrypt*",
          "kms:GenerateDataKey*",
          "kms:DescribeKey"
        ],
        Resource : "*"
      },
      {
        Sid : "Deny key deletion Permissions",
        Effect : "Deny",
        Principal : {
          AWS : "*"
        },
        Action : [
          "kms:Delete*",
          "kms:DisableKey",
          "kms:ScheduleKeyDeletion"
        ],
        Resource : "*",
        Condition : {
          "ArnNotEquals" : {
            "aws:SourceArn" : var.common_aliow_arns.delete
          }
        }
      }
    ]
  })
}

resource "aws_kms_alias" "common" {
  target_key_id = aws_kms_key.common.key_id
  name          = "alias/${var.common_alias}"
}

output "common_kms_key_arn" {
  value = aws_kms_key.common.arn
}

output "common_alias" {
  value = var.common_alias
}