module "sops_devart_id" {
  source       = "../../_modules/sops"
  common_alias = "sops"
  common_aliow_arns = {
    manage = [
      "arn:aws:iam::${var.account_id.id}:root"
    ]
    use = [
      "arn:aws:iam::${var.account_id.id}:root",
      local.remote_iam.sops_devart_id_common_role_arn
    ]
    delete = ["arn:aws:iam::${var.account_id.id}:root"]
  }
  secure_alias = "secure_sops"
  secure_aliow_arns = {
    manage = ["arn:aws:iam::${var.account_id.id}:root"]
    use = [
      "arn:aws:iam::${var.account_id.id}:root",
      local.remote_iam.sops_devart_id_secure_role_arn
    ]
    delete = ["arn:aws:iam::${var.account_id.id}:root"]
  }
}
