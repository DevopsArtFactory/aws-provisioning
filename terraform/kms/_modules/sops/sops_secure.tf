
resource "aws_kms_key" "secure" {
  description         = "KMS key for encrypt with sops the ${replace(replace(var.secure_alias, "-", " "), "_", " ")} secrets in ${var.region}."
  enable_key_rotation = true
  policy = jsonencode({
    Version : "2012-10-17"
    Id : "key-secure-1"
    Statement : [
      {
        Effect : "Allow",
        Principal : {
          AWS : var.secure_aliow_arns.manage
        },
        Action : "kms:*",
        Resource : "*"
      },
      {
        Sid : "Enable IAM Application Permissions",
        Effect : "Allow",
        Principal : {
          AWS : var.secure_aliow_arns.use
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
            "aws:SourceArn" : var.secure_aliow_arns.delete
          }
        }
      }
    ]
  })
}

resource "aws_kms_alias" "secure" {
  target_key_id = aws_kms_key.secure.key_id
  name          = "alias/${var.secure_alias}"
}

output "secure_kms_key_arn" {
  value = aws_kms_key.secure.arn
}

output "secure_alias" {
  value = var.secure_alias
}