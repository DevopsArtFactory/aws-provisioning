module "test-key" {

  source = "../_modules/aws_ssm_parameter"
  ssm_parameter_name = "test-key"

  ssm_parameter_key_id = "alias/deployment-common"
  
  ssm_parameter_description = "for testing"

  ssm_parameter_value       = var.secret-value
}
