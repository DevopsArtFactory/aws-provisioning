#
# art-prod administrator
#
resource "aws_iam_role" "assume_art_prod_admin" {
  name                 = "assume-art-prod-admin"
  path                 = "/"
  max_session_duration = "43200"
  assume_role_policy   = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::${var.id_account_id}:root"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "assume_art_prod_admin" {
  name = "assume-art-prod-admin-passrole"
  role = aws_iam_role.assume_art_prod_admin.id

  policy = <<EOF
{
  "Statement": [
    {
      "Sid": "AllowIAMPassRole",
      "Action": [
        "iam:PassRole"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "assume_art_prod_admin" {
  role       = aws_iam_role.assume_art_prod_admin.id
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}


