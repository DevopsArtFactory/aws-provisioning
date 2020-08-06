#
# art-prod readonly
#
resource "aws_iam_role" "assume_art_prod_readonly" {
  name = "assume-art-prod-readonly"
  path = "/"

  assume_role_policy = <<EOF
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

resource "aws_iam_role_policy" "assume_art_prod_readonly" {
  name = "assume-art-prod-readonly-passrole"
  role = aws_iam_role.assume_art_prod_readonly.id

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

resource "aws_iam_role_policy_attachment" "assume_art_prod_readonly" {
  role       = aws_iam_role.assume_art_prod_readonly.id
  policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}


