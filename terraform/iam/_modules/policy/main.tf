resource "aws_iam_policy" "policy" {
  name        = "${var.aws_account}-${var.subject}-policy"
  path        = "/"
  description = "${var.aws_account}-${var.subject}-policy"
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
