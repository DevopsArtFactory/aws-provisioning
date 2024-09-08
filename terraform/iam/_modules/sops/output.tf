output "common_role_arn" {
  value = aws_iam_role.common.arn
}

output "secure_role_arn" {
  value = aws_iam_role.secure.arn
}
