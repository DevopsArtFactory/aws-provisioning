# AWS kms Key
resource "aws_kms_key" "deployment_common" {
  description         = "KMS key for common secrets in ${var.aws_region}."
  enable_key_rotation = true
}

# Alias for custom key
resource "aws_kms_alias" "deployment_common_kms_alias" {
  name          = "alias/deployment-common"
  target_key_id = aws_kms_key.deployment_common.key_id
}

