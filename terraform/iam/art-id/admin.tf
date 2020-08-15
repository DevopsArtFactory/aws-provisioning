resource "aws_iam_role" "admin" {
  name               = "admin"
  path               = "/"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF

}

resource "aws_iam_role_policy" "admin" {
  name   = "admin-policy"
  role   = aws_iam_role.admin.id
  policy = <<EOF
{
  "Statement": [
    {
      "Sid": "AllowAppArtifactsReadAccess",
      "Action": [
        "*"
      ],
      "Resource": [
        "*"
      ],
      "Effect": "Allow"
    }
  ]
}
EOF

}


resource "aws_iam_instance_profile" "admin" {
  name = "admin-profile"
  role = aws_iam_role.admin.name
}

resource "aws_iam_role_policy_attachment" "admin_attach" {
  role       = aws_iam_role.admin.name
  policy_arn = aws_iam_policy.app_universal.arn
}

output "admin_instance_profile" {
  value = aws_iam_instance_profile.admin.arn
}
