data "terraform_remote_state" "vpc" {
  backend = "s3"

  config = merge(var.remote_state.vpc.artdapne2, { "role_arn" = var.assume_role_arn })
}


data "terraform_remote_state" "kms" {
  backend = "s3"

  config = merge(var.remote_state.kms.id.apne2, { "role_arn" = var.assume_role_arn })
}
