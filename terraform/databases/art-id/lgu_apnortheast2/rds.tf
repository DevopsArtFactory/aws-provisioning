resource "aws_db_subnet_group" "rds" {
  name        = "dbsubnets-${data.terraform_remote_state.vpc.outputs.vpc_name}"
  description = "The subnets used for RDS deployments"
  subnet_ids  = data.terraform_remote_state.vpc.outputs.db_private_subnets

  tags = {
    Name = "dbsubnets-${data.terraform_remote_state.vpc.outputs.vpc_name}"
  }
}

output "db_subnet_group_name" {
  value = aws_db_subnet_group.rds.name
}
