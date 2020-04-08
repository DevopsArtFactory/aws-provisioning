### Create policies for allowing user to assume the role in the production account
### You can copy this file and change `prod` to other environment if you have any other account

# Admin Access policy 
# If this policy is applied, then you will be able to assume role in the production account with admin permission
module "dayone_prod_admin" {
  source      = "./_module_assume_policy/"
  aws_account = "dayone-prod"
  subject     = "admin"
  resources   = ["arn:aws:iam::${var.prod_account_id}:role/assume-dayone-prod-admin"]
}

output "assume_dayone_prod_admin_policy_arn" {
  value = module.dayone_prod_admin.assume_policy_arn
}

# Poweruser Access policy 
# If this policy is applied, then you will be able to assume role in the production account with poweruser permission
module "dayone_prod_poweruser" {
  source      = "./_module_assume_policy/"
  aws_account = "dayone-prod"
  subject     = "poweruser"
  resources   = ["arn:aws:iam::${var.prod_account_id}:role/assume-dayone-prod-poweruser"]
}

output "assume_dayone_prod_poweruser_policy_arn" {
  value = module.dayone_prod_poweruser.assume_policy_arn
}


# ReadOnly Access policy 
# If this policy is applied, then you will be able to assume role in the production account with readonly permission
module "dayone_prod_readonly" {
  source      = "./_module_assume_policy/"
  aws_account = "dayone-prod"
  subject     = "readonly"
  resources   = ["arn:aws:iam::${var.prod_account_id}:role/assume-dayone-prod-readonly"]
}

output "assume_dayone_prod_readonly_policy_arn" {
  value = module.dayone_prod_readonly.assume_policy_arn
}

