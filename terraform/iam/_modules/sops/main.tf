resource "aws_iam_role" "common" {
  name = "${var.name}-sops"
  path = "/"

  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "",
        "Effect" : "Allow",
        "Principal" : {
          "AWS" : var.allowed_arns_for_common
        },
        "Action" : "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy" "common-passrole" {
  name = "${var.name}-sops-passrole"
  role = aws_iam_role.common.id

  policy = jsonencode({
    "Statement" : [
      {
        "Sid" : "AllowIAMPassRole",
        "Action" : [
          "iam:PassRole"
        ],
        "Effect" : "Allow",
        "Resource" : "*"
      }
    ]
  })
}

resource "aws_iam_role" "secure" {
  name = "${var.name}-secure-sops"
  path = "/"

  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "",
        "Effect" : "Allow",
        "Principal" : {
          "AWS" : var.allowed_arns_for_secure
        },
        "Action" : "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy" "secure-passrole" {
  name = "${var.name}-secure-sops-passrole"
  role = aws_iam_role.secure.id

  policy = jsonencode({
    "Statement" : [
      {
        "Sid" : "AllowIAMPassRole",
        "Action" : [
          "iam:PassRole"
        ],
        "Effect" : "Allow",
        "Resource" : "*"
      }
    ]
  })
}
