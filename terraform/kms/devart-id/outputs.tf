output "aws_kms_key_id_apne2_deployment_common_arn" {
  description = "Key for deployment"
  value       = aws_kms_key.deployment_common.arn
}