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
      "Sid": "AllowArtifactsReadAccess",
      "Action": [
        "s3:ListBucket",
        "s3:GetObject"
      ],
      "Effect": "Allow",
      "Resource": [
        "arn:aws:s3:::dayone-deploy",
        "arn:aws:s3:::dayone-deploy/*",
        "arn:aws:s3:::dayone-provisioning",
        "arn:aws:s3:::dayone-provisioning/*"
      ]
    },
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

resource "aws_iam_role_policy" "operation" {
  name   = "${var.service_name}-operation-access"
  role   = aws_iam_role.ec2.id
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "PackerSecurityGroupAccess",
      "Action": [
        "ec2:AttachVolume",
        "ec2:AuthorizeSecurityGroupIngress",
        "ec2:CopyImage",
        "ec2:CreateImage",
        "ec2:CreateKeypair",
        "ec2:CreateSecurityGroup",
        "ec2:CreateSnapshot",
        "ec2:CreateTags",
        "ec2:CreateVolume",
        "ec2:DeleteKeyPair",
        "ec2:DeleteSecurityGroup",
        "ec2:DeleteSnapshot",
        "ec2:DeleteVolume",
        "ec2:DeregisterImage",
        "ec2:DescribeImageAttribute",
        "ec2:DescribeImages",
        "ec2:DescribeInstances",
        "ec2:DescribeRegions",
        "ec2:DescribeSecurityGroups",
        "ec2:DescribeSnapshots",
        "ec2:DescribeSubnets",
        "ec2:DescribeTags",
        "ec2:DescribeVolumes",
        "ec2:DetachVolume",
        "ec2:GetPasswordData",
        "ec2:ModifyImageAttribute",
        "ec2:ModifyInstanceAttribute",
        "ec2:ModifySnapshotAttribute",
        "ec2:RegisterImage",
        "ec2:RunInstances",
        "ec2:StopInstances",
        "ec2:TerminateInstances",
        "ec2:RequestSpotInstances",
        "ec2:CancelSpotInstanceRequests",
        "ec2:DescribeSpotInstanceRequests",
        "ec2:DescribeSpotPriceHistory",
        "ec2:DescribeVpcClassicLink",
        "ec2:DescribeVpcClassicLinkDnsSupport",
        "ec2:DescribeVpcEndpointConnectionNotifications",
        "ec2:DescribeVpcEndpointConnections",
        "ec2:DescribeVpcEndpoints",
        "ec2:DescribeVpcEndpointServiceConfigurations",
        "ec2:DescribeVpcEndpointServicePermissions",
        "ec2:DescribeVpcEndpointServices",
        "ec2:DescribeVpcPeeringConnections",
        "ec2:DescribeVpcs",
        "ec2:DescribeAccountAttributes",
        "ec2:DescribeAvailabilityZones",
        "ec2:DescribeImages",
        "ec2:DescribeInstanceAttribute",
        "ec2:DescribeInstances",
        "ec2:DescribeKeyPairs",
        "ec2:DescribeLaunchTemplateVersions",
        "ec2:DescribePlacementGroups",
        "ec2:DescribeSecurityGroups",
        "ec2:DescribeSpotInstanceRequests",
        "ec2:DescribeSubnets",
        "ec2:DescribeVpcClassicLink",
        "autoscaling:*",
        "elasticloadbalancing:DescribeLoadBalancerAttributes",
        "elasticloadbalancing:DescribeLoadBalancers",
        "elasticloadbalancing:DescribeTargetGroupAttributes",
        "elasticloadbalancing:DescribeListeners",
        "elasticloadbalancing:DescribeTags",
        "elasticloadbalancing:DescribeTargetHealth",
        "elasticloadbalancing:DescribeTargetGroups",
        "elasticloadbalancing:DescribeRules",
        "elasticloadbalancing:DescribeTargetGroups",
        "elasticloadbalancing:DescribeLoadBalancerAttributes",
        "elasticloadbalancing:DescribeLoadBalancers",
        "elasticloadbalancing:DescribeTags",
        "elasticloadbalancing:DescribeInstanceHealth",
        "elasticloadbalancing:DescribeTargetGroups",
        "autoscaling:*",
        "codebuild:*"
      ],
      "Effect": "Allow",
      "Resource": ["*"]
    },
    {
      "Sid": "AllowGetAuthTokenAccess",
      "Effect": "Allow",
      "Action": [
        "iam:PassRole"
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

