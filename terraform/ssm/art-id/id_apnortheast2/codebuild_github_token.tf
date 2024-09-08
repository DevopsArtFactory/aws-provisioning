module "coddebuild_github_token" {
  source = "../_modules/aws_ssm_parameter"

  ssm_parameter_name = "/CodeBuild/GITHUB_TOKEN"

  ssm_parameter_key_id = data.terraform_remote_state.kms_apne2.outputs.aws_kms_key_id_apne2_deployment_common_arn
  ssm_parameter_value  = local.encrypted_values.github_token
}