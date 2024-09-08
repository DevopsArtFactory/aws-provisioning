############## art DevOps Group ##################
resource "aws_iam_group" "art_devops_white" {
  name = "art_devops_white"
}

resource "aws_iam_group_membership" "art_devops_white" {
  name = aws_iam_group.art_devops_white.name

  users = [
#    aws_iam_user.daniel_devart_com.name,
  ]

  group = aws_iam_group.art_devops_white.name
}

#######################################################

########### DevOps Assume Policies ####################
resource "aws_iam_group_policy_attachment" "art_devops_white" {
  count      = length(var.assume_policy_art_devops_white)
  group      = aws_iam_group.art_devops_white.name
  policy_arn = var.assume_policy_art_devops_white[count.index]
}

variable "assume_policy_art_devops_white" {
  description = "IAM Policy to be attached to user"
  type        = list(string)

  default = [
    # Please change <account_id> to the real account id number of id account
    "arn:aws:iam::816736805842:policy/assume-art-prod-readonly-policy", # Add readonly policy to while group user
  ]
}

#######################################################


############### MFA Manager ###########################
resource "aws_iam_group_policy_attachment" "art_devops_white_rotatekeys" {
  group      = aws_iam_group.art_devops_white.name
  policy_arn = aws_iam_policy.rotate_keys.arn
}

resource "aws_iam_group_policy_attachment" "art_devops_white_selfmanagemfa" {
  group      = aws_iam_group.art_devops_white.name
  policy_arn = aws_iam_policy.self_managed_mfa.arn
}
#######################################################

