resource "aws_ssm_parameter" "secret" {
  name        = var.ssm_parameter_name #"test-key"
  description = var.ssm_parameter_description
  type        = var.ssm_parameter_type
  key_id      = var.ssm_parameter_key_id
  value       = var.ssm_parameter_value

    lifecycle {
      ignore_changes = all
    }

}
