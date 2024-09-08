resource "aws_iam_role" "jenkins" {
  name               = "app-jenkins"
  path               = "/"
  assume_role_policy = data.aws_iam_policy_document.jenkins_assume_role_document.json
}

data "aws_iam_policy_document" "jenkins_assume_role_document" {
  statement {
    effect = "Allow"

    principals {
      type = "Service"
      identifiers = [
        "ec2.amazonaws.com",
        "codebuild.amazonaws.com",
        "s3.amazonaws.com"
      ]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role_policy" "jenkins_universal" {
  name   = "jenkins-universal"
  role   = aws_iam_role.jenkins.id
  policy = data.aws_iam_policy_document.jenkins_universal_document.json
}

data "aws_iam_policy_document" "jenkins_universal_document" {
  statement {
    sid       = "AllowAnsibleDescribeEc2TagsAccess"
    effect    = "Allow"
    resources = ["*"]
    actions   = ["ec2:DescribeTags"]
  }

  statement {
    sid       = "AllowVPCAccess"
    effect    = "Allow"
    resources = ["*"]
    actions = [
      "ec2:CreateNetworkInterface",
      "ec2:DescribeDhcpOptions",
      "ec2:DescribeNetworkInterfaces",
      "ec2:DeleteNetworkInterface",
      "ec2:DescribeSubnets",
      "ec2:DescribeSecurityGroups",
      "ec2:DescribeVpcs"
    ]
  }

  statement {
    sid    = "AllowEC2NetworkAccess"
    effect = "Allow"
    resources = [
      "arn:aws:ec2:ap-northeast-2:${var.account_id.id}:network-interface/*"
    ]
    actions = [
      "ec2:CreateNetworkInterfacePermission"
    ]
  }

  statement {
    sid    = "AllowSSMAccess"
    effect = "Allow"
    resources = [
      "*"
    ]
    actions = [
      "ssm:ResumeSession",
      "ssm:DescribeSessions",
      "ssm:TerminateSession",
      "ssm:StartSession",
      "ssm:UpdateInstanceInformation",
      "ssmmessages:CreateControlChannel",
      "ssmmessages:CreateDataChannel",
      "ssmmessages:OpenControlChannel",
      "ssmmessages:OpenDataChannel"
    ]
  }

  statement {
    sid    = "AllowEFSAccess"
    effect = "Allow"
    resources = [
      "*"
    ]
    actions = [
      "elasticfilesystem:DescribeFileSystems",
      "elasticfilesystem:DescribeMountTargets"
    ]
  }
  statement {
    sid    = "AllowGetEncryptionConfiguration"
    effect = "Allow"
    resources = [
      "*"
    ]
    actions = [
      "s3:GetEncryptionConfiguration"
    ]
  }

  statement {
    sid    = "AllowEC2MessagesPermission"
    effect = "Allow"
    resources = [
      "*"
    ]
    actions = [
      "ec2messages:AcknowledgeMessage",
      "ec2messages:DeleteMessage",
      "ec2messages:FailMessage",
      "ec2messages:GetEndpoint",
      "ec2messages:GetMessages",
      "ec2messages:SendReply"
    ]
  }
}

resource "aws_iam_role_policy" "jenkins_operation" {
  name   = "jenkins-operation-access"
  role   = aws_iam_role.jenkins.id
  policy = data.aws_iam_policy_document.jenkins_operation_document.json
}

data "aws_iam_policy_document" "jenkins_operation_document" {
  statement {
    sid       = "SecurityGroupAccess"
    effect    = "Allow"
    resources = ["*"]
    actions = [
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
      "codebuild:*",
      "elasticloadbalancing:RegisterTargets"
    ]
  }

  statement {
    sid    = "AllowGetAuthTokenAccess"
    effect = "Allow"
    resources = [
      "*"
    ]
    actions = [
      "iam:PassRole"
    ]
  }
}

resource "aws_iam_role_policy" "jenkins_ecr" {
  name   = "jenkins-ecr"
  role   = aws_iam_role.jenkins.id
  policy = data.aws_iam_policy_document.jenkins_ecr_document.json
}

data "aws_iam_policy_document" "jenkins_ecr_document" {
  statement {
    sid       = "AllowGetAuthTokenAccess"
    effect    = "Allow"
    resources = ["*"]
    actions = [
      "ecr:GetAuthorizationToken"
    ]
  }

  statement {
    sid    = "AllowReadECRAccess"
    effect = "Allow"
    resources = [
      "*"
    ]
    actions = [
      "ecr:BatchCheckLayerAvailability",
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage",
      "ecr:PutImage",
      "ecr:InitiateLayerUpload",
      "ecr:UploadLayerPart",
      "ecr:CompleteLayerUpload",
      "ecr:BatchCheckLayerAvailability",
      "ecr:DescribeRepositories",
      "ecr:GetRepositoryPolicy",
      "ecr:ListImages",
      "ecr:DescribeImages"
    ]
  }

  statement {
    sid    = "AllowReadAnotherAccountECRAccess"
    effect = "Allow"
    resources = [
      "arn:aws:ecr:ap-northeast-2:${var.account_id.id}:repository/*"
    ]
    actions = [
      "ecr:BatchCheckLayerAvailability",
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage",
      "ecr:PutImage",
      "ecr:InitiateLayerUpload",
      "ecr:UploadLayerPart",
      "ecr:CompleteLayerUpload",
      "ecr:BatchCheckLayerAvailability",
      "ecr:DescribeRepositories",
      "ecr:GetRepositoryPolicy",
      "ecr:ListImages",
      "ecr:DescribeImages"
    ]
  }
}

resource "aws_iam_role_policy" "jenkins_kms" {
  name   = "jenkins-kms-decryption"
  role   = aws_iam_role.jenkins.id
  policy = data.aws_iam_policy_document.jenkins_kms_ssm_document.json
}

data "aws_iam_policy_document" "jenkins_kms_ssm_document" {
  statement {
    sid    = "AllowToDecryptKMSKey"
    effect = "Allow"
    resources = [
      data.terraform_remote_state.kms_apne2.outputs.aws_kms_key_id_apne2_deployment_common_arn
    ]
    actions = [
      "kms:Decrypt"
    ]
  }

  statement {
    sid    = "AllowSsmParameterAccess"
    effect = "Allow"
    resources = [
      "arn:aws:ssm:ap-northeast-2:${var.account_id.id}:parameter/*"
    ]
    actions = [
      "ssm:GetParameter",
      "ssm:GetParameters"
    ]
  }
}

resource "aws_iam_role_policy" "jenkins_cloudwatch" {
  name   = "jenkins-cloudwatch"
  role   = aws_iam_role.jenkins.id
  policy = data.aws_iam_policy_document.jenkins_cloudwatch_document.json
}

data "aws_iam_policy_document" "jenkins_cloudwatch_document" {
  statement {
    sid    = "AllowCloudWatchAccess"
    effect = "Allow"
    resources = [
      "*"
    ]
    actions = [
      "logs:FilterLogEvents",
      "logs:DescribeLogStreams",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "logs:GetLogEvents"
    ]
  }
}

resource "aws_iam_instance_profile" "jenkins" {
  name = "app-jenkins-profile"
  role = aws_iam_role.jenkins.name
}

output "jenkins_instance_profile" {
  value = aws_iam_instance_profile.jenkins.arn
}

output "jenkins_arn" {
  value = aws_iam_role.jenkins.arn
}
