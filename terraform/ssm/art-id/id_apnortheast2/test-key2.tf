module "test-key2" {

  source = "../_modules/aws_ssm_parameter"
  ssm_parameter_name = "test-key2"

  ssm_parameter_key_id = "alias/deployment-common"
  
  ssm_parameter_description = "for testing"

  ssm_parameter_value       = var.secret-value2
}
