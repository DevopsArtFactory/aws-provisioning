data "terraform_remote_state" "vpc" {
  backend = "s3"
  config  = merge(var.remote_state.vpc.eksdapne2)
  #   config  = merge(var.remote_state.vpc.eksdapne2, {"assume_role" = {"role_arn" = var.assume_role_arn}})
}