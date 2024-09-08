resource "aws_kms_key" "deployment_common" {
  description         = "KMS key for common secrets in ${var.aws_region}."
  enable_key_rotation = true
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Id" : "deployment-common",
    "Statement" : [
      {
        "Sid" : "Enable IAM User Permissions",
        "Effect" : "Allow",
        "Principal" : {
          "AWS" : [
            "arn:aws:iam::${var.account_id.id}:root"
          ]
        },
        "Action" : "kms:*",
        "Resource" : "*"
      }
    ]
  })

}

resource "aws_kms_alias" "deployment_common_kms_alias" {
  name          = "alias/deployment-common"
  target_key_id = aws_kms_key.deployment_common.key_id
}
