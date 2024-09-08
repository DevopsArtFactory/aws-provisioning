resource "aws_iam_role" "codebuild_deployment" {
  name               = "codebuild-deployment"
  path               = "/service-role/"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "codebuild.amazonaws.com"
      },

      "Action": "sts:AssumeRole"

    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "codebuild_deployment_operation" {
  name   = "codebuild-deployment-operation-access"
  role   = aws_iam_role.codebuild_deployment.id
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "DeploymentSecurityGroupAccess",
      "Action": [
        "ec2:CreateSecurityGroup",
        "ec2:DescribeSecurityGroups",
        "ec2:AuthorizeSecurityGroupIngress",
        "ec2:RevokeSecurityGroupIngress"
      ],
      "Effect": "Allow",
      "Resource": ["*"]
    },
    {
      "Sid": "DeploymentAMIAccess",
      "Action": [
        "ec2:RegisterImage",
        "ec2:DescribeImages"
      ],
      "Effect": "Allow",
      "Resource": ["*"]
    },
    {
      "Sid": "DeploymentSnapshotAccess",
      "Action": [
        "ec2:CreateSnapshot",
        "ec2:DeleteSnaphot",
        "ec2:DescribeSnapshots"
      ],
      "Effect": "Allow",
      "Resource": ["*"]
    },
    {
      "Sid": "DeploymentInstanceAccess",
      "Action": [
        "ec2:RunInstances",
        "ec2:StartInstances",
        "ec2:StopInstances",
        "ec2:RebootInstances",
        "ec2:TerminateInstances",
        "ec2:DescribeInstances",
        "ec2:CreateTags",
        "ec2:DescribeTags",
        "ec2:ModifyInstanceAttribute"
      ],
      "Effect": "Allow",
      "Resource": ["*"]
    },
    {
      "Sid": "DeploymentKeyPairAccess",
      "Action": [
        "ec2:DescribeKeyPairs"
      ],
      "Effect": "Allow",
      "Resource": ["*"]
    },
    {
      "Sid": "LaunchTemplates",
      "Action": [
        "ec2:DeleteLaunchTemplate",
        "ec2:CreateLaunchTemplate",
        "ec2:GetLaunchTemplateData",
        "ec2:DescribeLaunchTemplates",
        "ec2:DescribeLaunchTemplateVersions",
        "ec2:ModifyLaunchTemplate",
        "ec2:DeleteLaunchTemplateVersions",
        "ec2:CreateLaunchTemplateVersion"
      ],
      "Effect": "Allow",
      "Resource": ["*"]
    },
    {
      "Sid": "DeploymentVolumeAccess",
      "Action": [
        "ec2:AttachVolume",
        "ec2:CreateVolume",
        "ec2:DeleteVolume",
        "ec2:DescribeVolume*",
        "ec2:DetachVolume"
      ],
      "Effect": "Allow",
      "Resource": ["*"]
    },
    {
      "Sid": "DeploymentASGAccess",
      "Action": [
        "autoscaling:*"
      ],
      "Effect": "Allow",
      "Resource": ["*"]
    },
    {
      "Sid": "DeploymentVPCAccess",
      "Action": [
        "ec2:CreateNetworkInterface",
        "ec2:DescribeDhcpOptions",
        "ec2:DescribeNetworkInterfaces",
        "ec2:DeleteNetworkInterface",
        "ec2:DescribeSubnets",
        "ec2:DescribeSecurityGroups",
        "ec2:DescribeVpcs"
      ],
      "Effect": "Allow",
      "Resource": ["*"]
    },
    {
      "Effect": "Allow",
      "Action": [
        "ec2:CreateNetworkInterfacePermission"
      ],
        "Resource": "arn:aws:ec2:ap-northeast-2:${var.account_id.id}:network-interface/*"
    },
    {
      "Sid": "DeploymentIAMAccess",
      "Action": [
        "iam:PassRole"
      ],
      "Effect": "Allow",
      "Resource": ["*"]
    },
    {
      "Sid": "DeploymentELBAccess",
      "Action": [
        "elasticloadbalancing:DescribeLoadBalancerAttributes",
        "elasticloadbalancing:DescribeLoadBalancers",
        "elasticloadbalancing:DescribeTargetGroupAttributes",
        "elasticloadbalancing:DescribeTargetHealth",
        "elasticloadbalancing:DescribeTargetGroups",
        "elasticloadbalancing:DescribeListeners",
        "elasticloadbalancing:DescribeTags",
        "elasticloadbalancing:DescribeRules",
        "elasticloadbalancing:DescribeInstanceHealth"
      ],
      "Effect": "Allow",
      "Resource": ["*"]
    },
    {
      "Sid": "CloudwatchAccess",
      "Action": [
        "cloudwatch:PutMetricAlarm"
      ],
      "Effect": "Allow",
      "Resource": ["*"]
    },
    {
      "Sid": "SSMSendCommand",
      "Action": [
        "ssm:SendCommand",
        "ssm:ListCommandInvocations"
      ],
      "Effect": "Allow",
      "Resource": ["*"]
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "codebuild_deployment_ecr" {
  name   = "codebuild-deployment-ecr"
  role   = aws_iam_role.codebuild_deployment.id
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

resource "aws_iam_role_policy" "codebuild_deployment_assume_deploy" {
  name   = "codebuild-deployment-assume-deploy"
  role   = aws_iam_role.codebuild_deployment.id
  policy = <<EOF
{
  "Statement": [
    {
      "Sid": "AllowAnsibleHeadDeployBucketAccess",
      "Action": [
        "sts:AssumeRole"
      ],
      "Resource": [
        "arn:aws:iam::002202845208:role/deployment"
      ],
      "Effect": "Allow"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "codebuild_deployment_kms" {
  name   = "codebuild-deployment-kms-decryption"
  role   = aws_iam_role.codebuild_deployment.id
  policy = <<EOF
{
  "Statement": [
    {
      "Sid": "AllowToDecryptKMSKey",
      "Action": [
        "kms:Decrypt"
      ],
      "Resource": [
        "${data.terraform_remote_state.kms_apne2.outputs.aws_kms_key_id_apne2_deployment_common_arn}"
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
        "arn:aws:ssm:ap-northeast-2:${var.account_id.id}:parameter/CodeBuild/*"
      ]
    }

  ]
}
EOF
}

resource "aws_iam_role_policy" "codebuild_deployment_cloudwatch" {
  name   = "codebuild-deployment-cloudwatch"
  role   = aws_iam_role.codebuild_deployment.id
  policy = <<EOF
{
  "Statement": [
    {
      "Sid": "AllowCloudWatchAccess",
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Resource": [
        "arn:aws:logs:*:${var.account_id.id}:log-group:/aws/codebuild/*",
        "arn:aws:logs:*:${var.account_id.id}:log-group:/aws/codebuild/*:*",
        "arn:aws:logs:*:${var.account_id.id}:log-group:/*",
        "arn:aws:logs:*:${var.account_id.id}:log-group:/*:*",
        "arn:aws:logs:*:${var.account_id.id}:log-group:/*:*:*",
        "arn:aws:logs:*:${var.account_id.id}:log-group:*:*:*/*"
      ],
      "Effect": "Allow"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "codebuild_deployment_dynamodb" {
  name   = "codebuild-deployment-dynamodb"
  role   = aws_iam_role.codebuild_deployment.id
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "CreateDynamoDB",
            "Effect": "Allow",
            "Action": [
                "dynamodb:CreateTable"
            ],
            "Resource": "*"
        },
        {
            "Sid": "ManageDynamoDB",
            "Effect": "Allow",
            "Action": [
                "dynamodb:DescribeTable",
                "dynamodb:PutItem",
                "dynamodb:DeleteItem",
                "dynamodb:GetItem",
                "dynamodb:Scan",
                "dynamodb:UpdateItem",
                "dynamodb:UpdateTable"
            ],
            "Resource": "arn:aws:dynamodb:ap-northeast-2:*:table/*goployer-*"
        }

    ]
}
EOF
}

resource "aws_iam_instance_profile" "codebuild_deployment" {
  name = "codebuild-deployment-profile"
  role = aws_iam_role.codebuild_deployment.name
}

resource "aws_iam_role_policy_attachment" "codebuild_deployment_attach" {
  role       = aws_iam_role.codebuild_deployment.name
  policy_arn = aws_iam_policy.app_universal.arn
}

output "codebuild_deployment_instance_profile" {
  value = aws_iam_instance_profile.codebuild_deployment.arn
}


output "codebuild_deployment_arn" {
  value = aws_iam_role.codebuild_deployment.arn
}
