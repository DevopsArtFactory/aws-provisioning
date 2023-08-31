output "aws_security_group_external_lb_id" {
  description = "instance security group"
  value       = aws_security_group.external_lb.id
}

output "aws_security_group_internal_lb_id" {
  description = "internal ALB security group"
  value       = aws_security_group.internal_lb.id
}
