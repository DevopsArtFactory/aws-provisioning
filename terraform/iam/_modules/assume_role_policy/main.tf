resource "aws_iam_policy" "policy" {
  name        = "${var.team}-${var.role}-${var.subject}-policy"
  path        = "/"
  description = "${var.team}-${var.role}-${var.subject}-policy"
  policy      = data.aws_iam_policy_document.policy-document.json
}

data "aws_iam_policy_document" "policy-document" {
  statement {
    effect = "Allow"

    resources = var.resources

    actions = [
      "sts:AssumeRole",
    ]
  }
}
