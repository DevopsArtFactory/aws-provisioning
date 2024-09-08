locals {
  handler_name = "${var.cluster_name}-aws-node-termination-handler"
  autoscaling_group_names = flatten(
    [for node_group in aws_eks_node_group.eks_node_group : [
      [for resources in node_group.resources : [
        [for asg in resources.autoscaling_groups : asg.name]
      ]]
    ]]
  )
  event_bridge_rules_params = [
    {
      name = "${var.cluster_name}-aws-node-termination-handler-spot-terminate"
      event_pattern = {
        source      = ["aws.ec2"]
        detail-type = ["EC2 Spot Instance Interruption Warning"]
      }
    },
    {
      name = "${var.cluster_name}-aws-node-termination-handler-health-check"
      event_pattern = {
        source      = ["aws.health"]
        detail-type = ["AWS Health Event"]
        detail = {
          service           = ["EC2"],
          eventTypeCategory = ["scheduledChange"]
        }
      }
    },
    # {
    #   name = "aws-node-termination-handler-autoscaling-terminate"
    #   event_pattern = {
    #     source      = ["aws.autoscaling"]
    #     detail-type = ["EC2 Instance-terminate Lifecycle Action"]
    #   }
    # },
    # {
    #   name = "aws-node-termination-handler-state-change"
    #   event_pattern = {
    #     source      = ["aws.ec2"]
    #     detail-type = ["EC2 Instance State-change Notification"]
    #   }
    # },
  ]
  event_bridge_rules = { for entry in local.event_bridge_rules_params : entry.name => entry }
  handle_target_tag = {
    key   = "aws-node-termination-handler/managed"
    value = "true" # The value of the key does not matter
  }
}


# SQS
resource "aws_sqs_queue" "aws_node_termination_handler_queue" {
  name                      = "${local.handler_name}-queue"
  sqs_managed_sse_enabled   = true
  message_retention_seconds = 43200
  tags = merge(var.tags, tomap({
    Name = "${local.handler_name}-queue"
  }))
}

resource "aws_sqs_queue_policy" "aws_node_termination_handler_queue" {
  queue_url = aws_sqs_queue.aws_node_termination_handler_queue.id
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Id" : "MyQueuePolicy",
    "Statement" : [{
      "Effect" : "Allow",
      "Principal" : {
        "Service" : ["events.amazonaws.com", "sqs.amazonaws.com"]
      },
      "Action" : "sqs:SendMessage",
      "Resource" : [
        "${aws_sqs_queue.aws_node_termination_handler_queue.arn}"
      ]
    }]
  })
}

# ASG from EKS
resource "aws_autoscaling_lifecycle_hook" "aws_node_termination_handler_asg" {
  count                  = length(var.node_group_configurations)
  name                   = "${local.autoscaling_group_names[count.index]}-asg"
  autoscaling_group_name = local.autoscaling_group_names[count.index]
  default_result         = "CONTINUE"
  heartbeat_timeout      = 300
  lifecycle_transition   = "autoscaling:EC2_INSTANCE_TERMINATING"

  depends_on = [aws_eks_node_group.eks_node_group]
}

resource "aws_autoscaling_group_tag" "aws_node_termination_handler_asg" {
  count                  = length(var.node_group_configurations)
  autoscaling_group_name = local.autoscaling_group_names[count.index]

  tag {
    key                 = local.handle_target_tag.key
    value               = local.handle_target_tag.value
    propagate_at_launch = true
  }

  depends_on = [aws_eks_node_group.eks_node_group]
}


# Event Bridge
resource "aws_cloudwatch_event_rule" "aws_node_termination_handler" {
  for_each      = local.event_bridge_rules
  name          = each.value.name
  event_pattern = jsonencode(each.value.event_pattern)
}

resource "aws_cloudwatch_event_target" "aws_node_termination_handler" {
  for_each = local.event_bridge_rules
  rule     = each.value.name
  arn      = aws_sqs_queue.aws_node_termination_handler_queue.arn

  depends_on = [
    aws_sqs_queue.aws_node_termination_handler_queue,
    aws_cloudwatch_event_rule.aws_node_termination_handler
  ]
}


# OIDC ( IAM Role for "aws_node_termination_handler" Pod )
resource "aws_iam_role" "aws_node_termination_handler" {
  name = "eks-${local.handler_name}"
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Federated" : "${local.openid_connect_provider_id}"
        },
        "Action" : "sts:AssumeRoleWithWebIdentity",
        "Condition" : {
          "StringEquals" : {
            "${local.openid_connect_provider_url}:aud" : "sts.amazonaws.com",
            "${local.openid_connect_provider_url}:sub" : "system:serviceaccount:kube-system:aws-node-termination-handler"
          }
        }
      }
    ]
  })
}

resource "aws_iam_policy" "aws_node_termination_handler" {
  name = "eks-${local.handler_name}-policy"
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : [
          "autoscaling:CompleteLifecycleAction",
          "autoscaling:DescribeAutoScalingInstances",
          "autoscaling:DescribeTags",
          "ec2:DescribeInstances",
          "sqs:DeleteMessage",
          "sqs:ReceiveMessage"
        ],
        "Resource" : "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "aws_node_termination_handler" {
  policy_arn = aws_iam_policy.aws_node_termination_handler.arn
  role       = aws_iam_role.aws_node_termination_handler.name
}
