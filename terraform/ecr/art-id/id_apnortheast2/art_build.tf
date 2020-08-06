resource "aws_ecr_repository" "art_build" {
  name = "art-build"
}

resource "aws_ecr_repository_policy" "art_build" {
  repository = aws_ecr_repository.art_build.name

  policy = <<EOF
{
    "Version": "2008-10-17",
    "Statement": [
        {
            "Sid": "new policy",
            "Effect": "Allow",
            "Principal": {
              "AWS": [
                "arn:aws:iam::816736805842:root"
              ]
            },
            "Action": [
                "ecr:GetDownloadUrlForLayer",
                "ecr:BatchGetImage",
                "ecr:BatchCheckLayerAvailability",
                "ecr:DescribeRepositories",
                "ecr:GetRepositoryPolicy",
                "ecr:ListImages"
            ]
        }
    ]
}
EOF
}
