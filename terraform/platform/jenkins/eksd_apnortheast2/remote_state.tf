data "terraform_remote_state" "kms_apne2" {
  backend = "s3"
  config  = merge(var.remote_state.kms.id.apne2)
  # config = merge(var.remote_state.kms.id.apne2, {"assume_role_arn" = { "role_arn" = var.assume_role_arn }})
}

data "terraform_remote_state" "vpc" {
  backend = "s3"
  config  = merge(var.remote_state.vpc.eksdapne2)
  # config = merge(var.remote_state.vpc.eksdapne2, {"assume_role_arn" = { "role_arn" = var.assume_role_arn }})
}

