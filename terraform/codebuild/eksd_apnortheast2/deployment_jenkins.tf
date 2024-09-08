module "deployment_jenkins" {
  source                 = "../_modules/deployment"
  service_name           = "jenkins"
  shard_id               = data.terraform_remote_state.vpc.outputs.shard_id
  private_subnets        = data.terraform_remote_state.vpc.outputs.private_subnets
  target_vpc             = data.terraform_remote_state.vpc.outputs.vpc_id
  vpc_name               = data.terraform_remote_state.vpc.outputs.vpc_name
  billing_tag            = data.terraform_remote_state.vpc.outputs.billing_tag
  deployment_default_sg  = data.terraform_remote_state.security_group.outputs.codebuild_deployment_id
  service_role           = "arn:aws:iam::${var.account_id.id}:role/service-role/codebuild-deployment"
  github_repo            = "https://github.com/DevopsArtFactory/jenkins-deploy-script.git"
  build_image            = "aws/codebuild/amazonlinux2-x86_64-standard:5.0"
  buildspec              = "buildspec.yml"
  image_credentials_type = "CODEBUILD"
  os_type                = "LINUX_CONTAINER"
  environment_variables  = local.jenkins_envirement_variables
}