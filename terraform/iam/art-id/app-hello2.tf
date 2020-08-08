resource "aws_iam_role" "app_hello2" {
  name               = "app-hello2"
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

resource "aws_iam_role_policy" "app_hello2_s3" {
  name   = "app-hello2-s3-artifact-download"
  role   = aws_iam_role.app_hello2.id
  policy = <<EOF
{
  "Statement": [
    {
      "Sid": "AllowAppArtifactsReadAccess",
      "Action": [
        "s3:GetObject"
      ],
      "Resource": [
        "arn:aws:s3:::art-deploy/hello2/",
        "arn:aws:s3:::art-deploy/hello2/*"
      ],
      "Effect": "Allow"
    }
  ]
}
EOF

}

resource "aws_iam_role_policy" "app_hello2_kms" {
  name   = "app-hello2-kms-decryption"
  role   = aws_iam_role.app_hello2.id
  policy = <<EOF
{
  "Statement": [
    {
      "Sid": "AllowSsmParameterAccess",
      "Action": [
        "ssm:GetParameter",
        "ssm:GetParameters"
      ],
      "Effect": "Allow",
      "Resource": [
        "arn:aws:ssm:*:*:parameter/github_token",
        "arn:aws:ssm:*:*:parameter/vault_*",
        "arn:aws:ssm:*:*:parameter/newrelic_token",
        "arn:aws:ssm:*:*:parameter/teleport_token"
      ]
    }
  ]
}
EOF

}


resource "aws_iam_instance_profile" "app_hello2" {
  name = "app-hello2-profile"
  role = aws_iam_role.app_hello2.name
}

resource "aws_iam_role_policy_attachment" "app_hello2_attach" {
  role       = aws_iam_role.app_hello2.name
  policy_arn = aws_iam_policy.app_universal.arn
}

output "hello2_instance_profile" {
  value = aws_iam_instance_profile.app_hello2.arn
}
