resource "aws_iam_role" "deployment" {
  name               = "deployment"
  path               = "/"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "AWS": [
          "arn:aws:iam::${var.id_account_id}:role/jenkins"
        ]
      },

      "Action": "sts:AssumeRole"

    }
  ]
}
EOF

}

resource "aws_iam_role_policy" "deployment_operation" {
  name   = "minimum-deployment-operation-access"
  role   = aws_iam_role.deployment.id
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
        "ec2:DescribeVpcs",
        "ec2:DescribeSubnets"
      ],
      "Effect": "Allow",
      "Resource": ["*"]
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
        "cloudwatch:PutMetricAlarm",
        "cloudwatch:Get*"
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

resource "aws_iam_instance_profile" "deployment" {
  name = "deployment-profile"
  role = aws_iam_role.deployment.name
}

output "deployment_instance_profile" {
  value = aws_iam_instance_profile.deployment.arn
}

