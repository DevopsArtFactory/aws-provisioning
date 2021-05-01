data "terraform_remote_state" "vpc" {
  backend = "s3"

  config = merge(var.remote_state.vpc.artpapne2, { "role_arn" = var.assume_role_arn })
}


data "terraform_remote_state" "kms" {
  backend = "s3"

  config = merge(var.remote_state.kms.prod.apne2, { "role_arn" = var.assume_role_arn })
}
