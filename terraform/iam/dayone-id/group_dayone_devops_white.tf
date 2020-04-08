############## Dayone DevOps Group ##################
resource "aws_iam_group" "dayone_devops_white" {
  name = "dayone_devops_white"
}

resource "aws_iam_group_membership" "dayone_devops_white" {
  name = aws_iam_group.dayone_devops_white.name

  users = [
    aws_iam_user.readonly_dayone.name,
  ]

  group = aws_iam_group.dayone_devops_white.name
}

#######################################################

########### Dayone DevOps users #####################

resource "aws_iam_user" "readonly_dayone" {  
  name = "readonly@dayone.com"       # Edit this value to the username you want to use 
}

#######################################################

############### DevOps Basic Policy ##################
######################################################

########### DevOps Assume Policies ####################
resource "aws_iam_group_policy_attachment" "dayone_devops_white" {
  count      = length(var.userassume_policy_dayone_devops_white)
  group      = aws_iam_group.dayone_devops_white.name
  policy_arn = var.userassume_policy_dayone_devops_white[count.index]
}

variable "userassume_policy_dayone_devops_white" {
  description = "IAM Policy to be attached to user"
  type        = list(string)

  default = [
    # Please change <account_id> to the real account id number of id account 
    "arn:aws:iam::<account_id>:policy/assume-dayone-prod-readonly-policy", # Add readonly policy to while group user
  ]
}

#######################################################


############### MFA Manager ###########################
resource "aws_iam_group_policy_attachment" "dayone_devops_white_rotatekeys" {
  group      = aws_iam_group.dayone_devops_white.name
  policy_arn = aws_iam_policy.RotateKeys.arn
}

resource "aws_iam_group_policy_attachment" "dayone_devops_white_selfmanagemfa" {
  group      = aws_iam_group.dayone_devops_white.name
  policy_arn = aws_iam_policy.SelfManageMFA.arn
}

resource "aws_iam_group_policy_attachment" "dayone_devops_white_forcemfa" {
  group      = aws_iam_group.dayone_devops_white.name
  policy_arn = aws_iam_policy.ForceMFA.arn
}

#######################################################

