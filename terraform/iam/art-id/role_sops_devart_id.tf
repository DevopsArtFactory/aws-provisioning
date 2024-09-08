module "sops_devart_id" {
  source = "../_modules/sops"
  name   = "devart-id"
  allowed_arns_for_common = [
    "arn:aws:iam::${var.account_id.id}:root"
  ]
  allowed_arns_for_secure = [
    "arn:aws:iam::${var.account_id.id}:root"
  ]
}

output "sops_devart_id_common_role_arn" {
  value = module.sops_devart_id.common_role_arn
}

output "sops_devart_id_secure_role_arn" {
  value = module.sops_devart_id.secure_role_arn
}