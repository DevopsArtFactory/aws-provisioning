data "terraform_remote_state" "vpc" {
  backend = "s3"

  config = merge(var.remote_state.vpc.artdapne2, { "role_arn" = var.assume_role_arn })
}

data "terraform_remote_state" "iam" {
  backend = "s3"

  config = merge(var.remote_state.iam.id, { "role_arn" = var.assume_role_arn })
}

