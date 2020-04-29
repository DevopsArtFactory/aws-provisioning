# Create DB Subnet with private db subnet created with VPC
resource "aws_db_subnet_group" "rds" {
  name        = "dbsubnets-${data.terraform_remote_state.vpc.outputs.vpc_name}"
  description = "The subnets used for dayone RDS deployments"
  subnet_ids  = data.terraform_remote_state.vpc.outputs.db_private_subnets

  tags = {
    Name = "dbsubnets-${data.terraform_remote_state.vpc.outputs.vpc_name}"
  }
}
