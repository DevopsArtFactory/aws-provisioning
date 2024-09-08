data "terraform_remote_state" "vpc" {
  backend = "s3"
  config  = merge(var.remote_state.vpc.eksdapne2)

  # config = merge(var.remote_state.vpc.eksdapne2, { "assume_role" = { "role_arn" = var.assume_role_arn } })
}

data "terraform_remote_state" "iam" {
  backend = "s3"
  config  = merge(var.remote_state.iam.id)

  # config = merge(var.remote_state.iam.id, { "assume_role" = { "role_arn" = var.assume_role_arn } })
}

data "terraform_remote_state" "security_group" {
  backend = "s3"
  config = merge(var.remote_state.security_group.id.eksdapne2)

  # config = merge(var.remote_state.security_group.id.eksdapne2, { "assume_role" = { "role_arn" = var.assume_role_arn } })
}
