resource "aws_iam_role" "app_hello" {
  name               = "app-hello"
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

resource "aws_iam_role_policy" "app_hello_s3" {
  name   = "app-hello-s3-artifact-download"
  role   = aws_iam_role.app_hello.id
  policy = <<EOF
{
  "Statement": [
    {
      "Sid": "AllowAppArtifactsReadAccess",
      "Action": [
        "s3:GetObject"
      ],
      "Resource": [
        "arn:aws:s3:::art-deploy/hello/",
        "arn:aws:s3:::art-deploy/hello/*"
      ],
      "Effect": "Allow"
    }
  ]
}
EOF

}

resource "aws_iam_role_policy" "app_hello_kms" {
  name   = "app-hello-kms-decryption"
  role   = aws_iam_role.app_hello.id
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


resource "aws_iam_instance_profile" "app_hello" {
  name = "app-hello-profile"
  role = aws_iam_role.app_hello.name
}

resource "aws_iam_role_policy_attachment" "app_hello_attach" {
  role       = aws_iam_role.app_hello.name
  policy_arn = aws_iam_policy.app_universal.arn
}

output "hello_instance_profile" {
  value = aws_iam_instance_profile.app_hello.arn
}
