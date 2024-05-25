#
# art-prod administrator
#
resource "aws_iam_role" "assume_art_prod_admin" {
  name                 = "assume-art-prod-admin"
  path                 = "/"
  max_session_duration = "43200"
  assume_role_policy   = data.aws_iam_policy_document.assume_art_prod_admin_assume_role.json
}

data "aws_iam_policy_document" "assume_art_prod_admin_assume_role" {
  statement {
    actions = ["sts:AssumeRole"]
    effect  = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${var.id_account_id}:root"]
    }
  }
}

resource "aws_iam_role_policy" "assume_art_prod_admin_passrole" {
  name = "assume-art-prod-admin-passrole"
  role = aws_iam_role.assume_art_prod_admin.id

  policy = data.aws_iam_policy_document.assume_art_prod_admin_pass_role.json
}

data "aws_iam_policy_document" "assume_art_prod_admin_pass_role" {
    statement {
        actions = ["iam:PassRole"]
        effect  = "Allow"

        resources = ["*"]
    }
}

resource "aws_iam_role_policy_attachment" "assume_art_prod_admin" {
  role       = aws_iam_role.assume_art_prod_admin.id
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}


