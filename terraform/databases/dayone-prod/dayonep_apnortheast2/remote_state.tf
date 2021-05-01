# Set Configuration to use VPC Information via remote_state
# VPC backend configuration is located in terraform/variables/var_global.tf
data "terraform_remote_state" "vpc" {
  backend = "s3"

  # merge function is used to merge the key-value pairs from two different map
  config = merge(var.remote_state.vpc.dayonepapne2, { "role_arn" = var.assume_role_arn })

  # You can also set like this. 
  # You should define variables to variables.tf and value of them to terraform.tfvars  
  #config = {
  #  bucket       = var.remote_state_bucket
  #  region       = var.remote_state_region
  #  key          = var.remote_state_key
  #  role_arn     = var.assume_role_arn
  #  session_name = var.atlantis_user
  #}
}
