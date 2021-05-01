module "deployment" {
  source           = "../_modules/deployment"
  service_name     = "deployment-prod"
  shard_id         = data.terraform_remote_state.vpc.outputs.shard_id
  public_subnets   = data.terraform_remote_state.vpc.outputs.public_subnets
  private_subnets  = data.terraform_remote_state.vpc.outputs.private_subnets
  aws_region       = data.terraform_remote_state.vpc.outputs.aws_region
  target_vpc       = data.terraform_remote_state.vpc.outputs.vpc_id
  vpc_name         = data.terraform_remote_state.vpc.outputs.vpc_name
  vpc_cidr_numeral = data.terraform_remote_state.vpc.outputs.cidr_numeral
  billing_tag      = data.terraform_remote_state.vpc.outputs.billing_tag
  env_suffix       = data.terraform_remote_state.vpc.outputs.env_suffix

  image_credentials_type = "SERVICE_ROLE"

  # Change this to your security group ID
  deployment_default_sg = data.terraform_remote_state.vpc.outputs.aws_security_group_codebuild_default_id

  # Change this to your IAM role
  service_role = "arn:aws:iam::816736805842:role/service-role/codebuild-deployment"

  # Change this repository which you want to pull code from.
  # In this repository, it should have buildspec file that you specify below
  github_repo = "https://github.com/DevopsArtFactory/goployer.git"

  # buildspec file name you want to use
  buildspec = "buildspec-deploy-prod.yml"

  # Change this to your docker image that you want to use for codebuild
  build_image = "816736805842.dkr.ecr.ap-northeast-2.amazonaws.com/art-build:latest"
}
