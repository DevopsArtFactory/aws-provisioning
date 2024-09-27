data "terraform_remote_state" "vpc" {
  backend = "s3"
  config  = merge(var.remote_state.vpc.eksduse1)
  # config  = merge(var.remote_state.vpc.eksduse1, { "assume_role" = { "role_arn" = var.assume_role_arn } })
}
