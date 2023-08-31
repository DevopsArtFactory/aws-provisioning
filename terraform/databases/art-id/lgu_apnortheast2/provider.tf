provider "aws" {
  region = data.terraform_remote_state.vpc.outputs.aws_region

  assume_role {
    role_arn     = var.assume_role_arn
    session_name = var.atlantis_user
  }
}
