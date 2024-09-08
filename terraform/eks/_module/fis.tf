resource "aws_fis_experiment_template" "aws_node_termination_handler_fis" {
  description = "Spot Interrupt for testing node termination handler"

  action {
    name        = "instance-terminate"
    action_id   = "aws:ec2:send-spot-instance-interruptions"
    description = "Terminate spots"

    parameter {
      key   = "durationBeforeInterruption"
      value = "PT2M"
    }

    target {
      key   = "SpotInstances"
      value = "eks-spot-node-nth-handled"
    }
  }

  target {
    name           = "eks-spot-node-nth-handled"
    resource_type  = "aws:ec2:spot-instance"
    selection_mode = "COUNT(1)"

    resource_tag {
      key   = local.handle_target_tag.key
      value = local.handle_target_tag.value
    }

    resource_tag {
      key   = "aws:eks:cluster-name"
      value = var.cluster_name
    }

    filter {
      path   = "State.Name"
      values = ["running"]
    }
  }

  stop_condition {
    source = "none"
  }

  tags = {
    Name = "aws_node_termination_handler_fis"
  }

  role_arn = aws_iam_role.aws_node_termination_handler_fis.arn
}

resource "aws_iam_role" "aws_node_termination_handler_fis" {
  name = "eks-${local.handler_name}-fis-role"
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Service" : [
            "fis.amazonaws.com"
          ]
        },
        "Action" : "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_policy" "aws_node_termination_handler_fis" {
  name        = "eks-${local.handler_name}-fis-policy"
  description = "For FIS with Note Termination Handler"
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Action" : [
          "ec2:SendSpotInstanceInterruptions",
          "ec2:TerminateInstances"
        ],
        "Resource" : "arn:aws:ec2:*:${var.account_id}:instance/*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "aws_node_termination_handler_fis" {
  policy_arn = aws_iam_policy.aws_node_termination_handler_fis.arn
  role       = aws_iam_role.aws_node_termination_handler_fis.name
}
