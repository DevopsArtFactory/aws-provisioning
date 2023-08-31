resource "aws_security_group" "lgu_mysql" {
  name        = "lgu-mysql-${data.terraform_remote_state.vpc.outputs.shard_id}"
  description = "lgu mysql SG"
  vpc_id      = data.terraform_remote_state.vpc.outputs.vpc_id

  ingress {
    from_port = 3060
    to_port   = 3060
    protocol  = "tcp"

    security_groups = [
      #lguapne2 eks cluster sg
      data.terraform_remote_state.eks.outputs.aws_security_group_eks_cluster_default_id,
    ]
  }

  tags = {
    Name = "lgu-mysql-${data.terraform_remote_state.vpc.outputs.shard_id}"
  }
}

resource "aws_route53_record" "lgu_db" {
  zone_id = data.terraform_remote_state.vpc.outputs.route53_internal_zone_id
  name    = "lgu-db.${data.terraform_remote_state.vpc.outputs.route53_internal_domain}"
  type    = "CNAME"
  ttl     = 60
  records = [var.lgu_mysql_endpoint]
}

resource "aws_rds_cluster_parameter_group" "lgu_mysql_cluster_pg" {
  name        = "lgu-mysql-${data.terraform_remote_state.vpc.outputs.shard_id}-cluster-pg"
  family      = "mysql8.0"
  description = "lgu RDS cluster parameter group"

  dynamic "parameter" {
    for_each = var.cluster_parameters
    content {
      name         = parameter.value.name
      value        = parameter.value.value
      apply_method = parameter.value.apply_method
    }
  }
}

resource "aws_db_parameter_group" "lgu_mysql_pg" {
  name   = "lgu-mysql-${data.terraform_remote_state.vpc.outputs.shard_id}-pg"
  family      = "mysql8.0"

  dynamic "parameter" {
    for_each = var.db_parameters
    content {
      name         = parameter.value.name
      value        = parameter.value.value
      apply_method = parameter.value.apply_method
    }
  }
}


variable "cluster_parameters" {
  type = list(any)
  default = [
    {
      apply_method = ""
      name         = ""
      value        = ""
    }
  ]
}

variable "db_parameters" {
  type = list(any)
  default = [
    {
      apply_method = ""
      name         = ""
      value        = ""
    }
  ]
}
