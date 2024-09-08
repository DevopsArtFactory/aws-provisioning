resource "aws_iam_user" "user" {
  name          = var.company_email
  force_destroy = var.force_destroy
  tags = {
    role         = var.role
  }
}

