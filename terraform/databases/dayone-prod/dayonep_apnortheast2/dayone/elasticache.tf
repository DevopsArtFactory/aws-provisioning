################# Dayone First Redis Cluster ###################
resource "aws_elasticache_replication_group" "dayone_redis_cluster" {
  replication_group_id          = "dayone-cl-${data.terraform_remote_state.vpc.outputs.shard_id}"
  replication_group_description = "dayone redis cluster replica group"

  # Change the node type 
  node_type = "cache.r5.large"

  # Change the port you want to use 
  port = 6379

  # Change the engine version
  engine_version = "5.0.3"

  # Specify the subnet group we created before
  subnet_group_name = "subnets-${data.terraform_remote_state.vpc.outputs.shard_id}"

  # Specify the security group for redis elastiscache
  security_group_ids = [aws_security_group.dayone_redis.id]

  # Specify the parameter group for redis elastiscache
  parameter_group_name       = aws_elasticache_parameter_group.dayone_redis_cluster_pg.name
  automatic_failover_enabled = true


  # Configuration for cluster mode
  cluster_mode {
    replicas_per_node_group = 1
    num_node_groups         = 1
  }

  tags = {
    Name    = "dayone-redis-cluster"
    project = "dayone"
    role    = "redis"
    billing = data.terraform_remote_state.vpc.outputs.billing_tag
    stack   = data.terraform_remote_state.vpc.outputs.vpc_name
    region  = data.terraform_remote_state.vpc.outputs.aws_region
  }
}

# Route53 Record for elasticache
resource "aws_route53_record" "dayone_redis_cluster" {
  zone_id = data.terraform_remote_state.vpc.outputs.route53_internal_zone_id
  name    = "dayone-redis-cluster.${data.terraform_remote_state.vpc.outputs.route53_internal_domain}"
  type    = "CNAME"
  ttl     = 300
  records = [aws_elasticache_replication_group.dayone_redis_cluster.configuration_endpoint_address]
}
######################################################

