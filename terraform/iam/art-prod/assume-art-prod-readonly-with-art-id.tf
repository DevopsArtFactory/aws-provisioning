#
# art-prod readonly
#
resource "aws_iam_role" "assume_art_prod_readonly" {
  name                 = "assume-art-prod-readonly"
  path                 = "/"
  max_session_duration = "43200"
  assume_role_policy   = data.aws_iam_policy_document.assume_art_prod_readonly_assume_role.json
}

data "aws_iam_policy_document" "assume_art_prod_readonly_assume_role" {
  statement {
    actions = ["sts:AssumeRole"]
    effect  = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${var.id_account_id}:root"]
    }
  }
}

resource "aws_iam_role_policy" "assume_art_prod_readonly_passrole" {
  name = "assume-art-prod-readonly-passrole"
  role = aws_iam_role.assume_art_prod_readonly.id

  policy = data.aws_iam_policy_document.assume_art_prod_readonly_pass_role.json
}

data "aws_iam_policy_document" "assume_art_prod_readonly_pass_role" {
  statement {
    actions = ["iam:PassRole"]
    effect  = "Allow"

    resources = ["*"]
  }
}

resource "aws_iam_role_policy_attachment" "assume_art_prod_readonly" {
  role       = aws_iam_role.assume_art_prod_readonly.id
  policy_arn = "arn:aws:iam::aws:policy/ReadOnlyAccess"
}


