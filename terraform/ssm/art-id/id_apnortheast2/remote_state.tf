data "terraform_remote_state" "kms_apne2" {
  backend = "s3"

  config  = merge(var.remote_state.kms.id.apne2)
    # config = merge(var.remote_state.kms.id.apne2, {"assume_role_arn" = { "role_arn" = var.assume_role_arn }})

}
