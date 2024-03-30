data "terraform_remote_state" "vpc" {
  backend = "s3"

  config = merge(var.remote_state.vpc.devartsapne2, { "role_arn" = var.assume_role_arn })
}
