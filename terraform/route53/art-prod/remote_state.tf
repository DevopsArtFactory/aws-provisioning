# Set Configuration to use VPC Information via remote_state
# VPC backend configuration is located in terraform/variables/var_global.tf
data "terraform_remote_state" "vpc" {
  backend = "s3"

  # merge function is used to merge the key-value pairs from two different map
  config = merge(var.remote_state.vpc.artapne2, { "role_arn" = var.assume_role_arn })
}

