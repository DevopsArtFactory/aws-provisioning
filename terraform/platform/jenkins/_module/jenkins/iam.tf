resource "aws_iam_role" "ec2" {
  name               = var.service_name
  path               = "/"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
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

resource "aws_iam_role_policy" "universal" {
  name   = "${var.service_name}-universal"
  role   = aws_iam_role.ec2.id
  policy = <<EOF
{
  "Statement": [
    {
      "Sid": "AllowAnsibleDescribeEc2TagsAccess",
      "Action": "ec2:DescribeTags",
      "Resource": "*",
      "Effect": "Allow"
    },
    {
      "Sid": "AllowVPCAccess",
      "Effect": "Allow",
      "Action": [
        "ec2:CreateNetworkInterface",
        "ec2:DescribeDhcpOptions",
        "ec2:DescribeNetworkInterfaces",
        "ec2:DeleteNetworkInterface",
        "ec2:DescribeSubnets",
        "ec2:DescribeSecurityGroups",
        "ec2:DescribeVpcs"
      ],
        "Resource": "*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "ec2:CreateNetworkInterfacePermission"
      ],
        "Resource": "arn:aws:ec2:ap-northeast-2:${var.account_id}:network-interface/*"
    },
    {
        "Effect": "Allow",
        "Action": [
            "ssm:ResumeSession",
            "ssm:DescribeSessions",
            "ssm:TerminateSession",
            "ssm:StartSession",
            "ssm:UpdateInstanceInformation",
            "ssmmessages:CreateControlChannel",
            "ssmmessages:CreateDataChannel",
            "ssmmessages:OpenControlChannel",
            "ssmmessages:OpenDataChannel"
        ],
        "Resource": "*"
    },
    {
        "Effect": "Allow",
        "Action": [
            "s3:GetEncryptionConfiguration"
        ],
        "Resource": "*"
    },
    {
        "Effect": "Allow",
        "Action": [
            "ec2messages:AcknowledgeMessage",
            "ec2messages:DeleteMessage",
            "ec2messages:FailMessage",
            "ec2messages:GetEndpoint",
            "ec2messages:GetMessages",
            "ec2messages:SendReply"
        ],
        "Resource": "*"
    }
  ]
}
EOF

}


resource "aws_iam_role_policy" "ecr" {
  name   = "${var.service_name}-ecr"
  role   = aws_iam_role.ec2.id
  policy = <<EOF
{
  "Statement": [
    {
      "Sid": "AllowGetAuthTokenAccess",
      "Effect": "Allow",
      "Action": [
        "ecr:GetAuthorizationToken"
      ],
      "Resource": "*"
    },
    {
      "Sid": "AllowReadECRAccess",
      "Effect": "Allow",
        "Action": [
          "ecr:BatchCheckLayerAvailability",
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage",
          "ecr:PutImage",
          "ecr:InitiateLayerUpload",
          "ecr:UploadLayerPart",
          "ecr:CompleteLayerUpload"
        ],
        "Resource": "*"
    }
    
  ]
}
EOF

}

resource "aws_iam_role_policy" "kms" {
  name   = "${var.service_name}-kms-decryption"
  role   = aws_iam_role.ec2.id
  policy = <<EOF
{
  "Statement": [
    {
      "Sid": "AllowToDecryptKMSKey",
      "Action": [
        "kms:Decrypt"
      ],
      "Resource": [
        "${var.deployment_common_arn}"
      ],
      "Effect": "Allow"
    },
    {
      "Sid": "AllowSsmParameterAccess",
      "Action": [
        "ssm:GetParameter",
        "ssm:GetParameters"
      ],
      "Effect": "Allow",
      "Resource": [
        "arn:aws:ssm:ap-northeast-2:${var.account_id}:parameter/*"
      ]
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "assume_deploy" {
  name   = "${var.service_name}-assume-deploy"
  role   = aws_iam_role.ec2.id
  policy = <<EOF
{
  "Statement": [
    {
      "Sid": "AllowAnsibleHeadDeployBucketAccess",
      "Action": [
        "sts:AssumeRole"
      ],
      "Resource": [
        "arn:aws:iam::${var.account_id}:role/deployment"
      ],
      "Effect": "Allow"
    }
  ]
}
EOF
}

resource "aws_iam_instance_profile" "instance_profile" {
  name = "${var.service_name}-profile"
  role = aws_iam_role.ec2.name
}

output "instance_profile" {
  value = aws_iam_instance_profile.instance_profile.arn
}

