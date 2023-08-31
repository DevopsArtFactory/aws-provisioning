data "terraform_remote_state" "vpc" {
  backend = "s3"

  config = merge(var.remote_state.vpc.lguapne2, { "role_arn" = var.assume_role_arn })
}

data "terraform_remote_state" "eks" {
  backend = "s3"

  config = merge(var.remote_state.eks.id.lguapne2, { "role_arn" = var.assume_role_arn })
}

data "terraform_remote_state" "databases" {
  backend = "s3"

  config = merge(var.remote_state.databases.id.lguapne2, { "role_arn" = var.assume_role_arn })
}

# data "terraform_remote_state" "sg" {
#   backend = "s3"

#   config = merge(var.remote_state.sg.id.lgu_apnortheast2, { "role_arn" = var.assume_role_arn })
# }
