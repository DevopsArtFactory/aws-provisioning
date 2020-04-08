############## Dayone DevOps Group ##################
resource "aws_iam_group" "dayone_devops_black" {
  name = "dayone_devops_black"
}

resource "aws_iam_group_membership" "dayone_devops_black" {
  name = aws_iam_group.dayone_devops_black.name

  users = [
    aws_iam_user.admin_dayone.name
  ]

  group = aws_iam_group.dayone_devops_black.name
}

#######################################################

########### Dayone DevOps users #####################

resource "aws_iam_user" "admin_dayone" {  
  name = "admin@dayone.com"       # Edit this value to the username you want to use 
}

#######################################################

############### DevOps Basic Policy ##################
######################################################

########### DevOps Assume Policies ####################
resource "aws_iam_group_policy_attachment" "dayone_devops_black" {
  count      = length(var.userassume_policy_dayone_devops_black)
  group      = aws_iam_group.dayone_devops_black.name
  policy_arn = var.userassume_policy_dayone_devops_black[count.index]
}

variable "userassume_policy_dayone_devops_black" {
  description = "IAM Policy to be attached to user"
  type        = list(string)

  default = [
    # Please change <account_id> to the real account id number of id account 
    "arn:aws:iam::<account_id>:policy/assume-dayone-prod-admin-policy", # Add admin policy to black group user 
  ]
}

#######################################################


############### MFA Manager ###########################
resource "aws_iam_group_policy_attachment" "dayone_devops_black_rotatekeys" {
  group      = aws_iam_group.dayone_devops_black.name
  policy_arn = aws_iam_policy.RotateKeys.arn
}

resource "aws_iam_group_policy_attachment" "dayone_devops_black_selfmanagemfa" {
  group      = aws_iam_group.dayone_devops_black.name
  policy_arn = aws_iam_policy.SelfManageMFA.arn
}

resource "aws_iam_group_policy_attachment" "dayone_devops_black_forcemfa" {
  group      = aws_iam_group.dayone_devops_black.name
  policy_arn = aws_iam_policy.ForceMFA.arn
}

#######################################################

