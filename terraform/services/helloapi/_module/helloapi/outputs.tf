output "aws_security_group_ec2_id" {
  description = "ec2 instance security group"
  value       = aws_security_group.ec2.id
}

