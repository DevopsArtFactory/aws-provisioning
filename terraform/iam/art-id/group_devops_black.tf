############## art DevOps Group ##################
resource "aws_iam_group" "art_devops_black" {
  name = "art_devops_black"
}

resource "aws_iam_group_membership" "art_devops_black" {
  name = aws_iam_group.art_devops_black.name

  users = [
#    aws_iam_user.jupiter_devart_com.name,
    aws_iam_user.jupiter_song.name,
    aws_iam_user.gslee.name,
    aws_iam_user.jwkang.name,
    aws_iam_user.asbubam.name,
    aws_iam_user.zerojin0312.name,
  ]

  group = aws_iam_group.art_devops_black.name
}

############### DevOps Basic Policy ##################
resource "aws_iam_group_policy" "art_devops_black" {
  name  = "art_devops_black"
  group = aws_iam_group.art_devops_black.id

  policy = data.aws_iam_policy_document.art_devops_black.json
}

data "aws_iam_policy_document" "art_devops_black" {
  statement {
    actions = [
      "*"
    ]

    resources = [
      "*"
    ]
  }
}

######################################################

########### DevOps Assume Policies ####################
resource "aws_iam_group_policy_attachment" "art_devops_black" {
  count      = length(var.assume_policy_art_devops_black)
  group      = aws_iam_group.art_devops_black.name
  policy_arn = var.assume_policy_art_devops_black[count.index]
}

variable "assume_policy_art_devops_black" {
  description = "IAM Policy to be attached to user"
  type        = list(string)

  default = [
    # Please change <account_id> to the real account id number of id account 
    "arn:aws:iam::816736805842:policy/assume-art-prod-admin-policy", # Add admin policy to black group user 
  ]
}

#######################################################


############### MFA Manager ###########################
resource "aws_iam_group_policy_attachment" "art_devops_black_rotatekeys" {
  group      = aws_iam_group.art_devops_black.name
  policy_arn = aws_iam_policy.rotate_keys.arn
}

resource "aws_iam_group_policy_attachment" "art_devops_black_selfmanagemfa" {
  group      = aws_iam_group.art_devops_black.name
  policy_arn = aws_iam_policy.self_managed_mfa.arn
}
#######################################################

