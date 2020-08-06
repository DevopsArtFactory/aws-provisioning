data "terraform_remote_state" "kms_apne2" {
  backend = "s3"

  config = {
    bucket       = var.remote_state_bucket
    region       = var.remote_state_region
    key          = var.remote_state_key_map["kms_apne2"]
    role_arn     = var.assume_role_arn
    session_name = var.atlantis_user
  }
}
