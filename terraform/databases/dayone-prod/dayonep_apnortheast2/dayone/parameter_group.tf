# Aurora Parameter Group
# This is for the database instance not the cluster.
resource "aws_db_parameter_group" "dayone_aurora_pg" {
  name = "dayone-aurora-${data.terraform_remote_state.vpc.outputs.shard_id}-pg"

  # Please change this value to version you want to use 
  family = "aurora-mysql5.7"

  # From this, you could override the default value of DB parameter
  parameter {
    # Enable Slow query logging
    name  = "slow_query_log"
    value = "1"
  }

  parameter {
    # Set long query time to 1 second 
    name  = "long_query_time"
    value = "1"
  }

  parameter {
    # Set DB connection timeout to 5 seconds
    name  = "connect_timeout"
    value = "5"
  }

  parameter {
    # Increase the maximum number of connections to 16000 which is the maximum of aurora DB connection
    name  = "max_connections"
    value = 16000
  }

  parameter {
    # Disable performance schema
    name         = "performance_schema"
    value        = 0
    apply_method = "pending-reboot" #  Changes applied when DB is rebooted
  }
}

# Aurora Cluster Parameter Group
# This is for the cluster of instances not the instance
resource "aws_rds_cluster_parameter_group" "dayone_aurora_cluster_pg" {
  name = "dayone-aurora-${data.terraform_remote_state.vpc.outputs.shard_id}-cluster-pg"

  # Please change this value to version you want to use 
  family = "aurora-mysql5.7"

  description = "dayone RDS cluster parameter group"

  parameter {
    # Set Timezone to Seoul
    name  = "time_zone"
    value = "asia/seoul"
  }

  parameter {
    # Enable Slow query Logging
    name  = "slow_query_log"
    value = "1"
  }

  parameter {
    # Set long query time to 1 second 
    name  = "long_query_time"
    value = "1"
  }

  parameter {
    # Set server collation
    name  = "collation_server"
    value = "utf8mb4_bin"
  }

  parameter {
    name  = "character_set_connection"
    value = "utf8mb4"
  }

  parameter {
    name  = "character_set_server"
    value = "utf8mb4"
  }

  parameter {
    name  = "character_set_client"
    value = "utf8mb4"
  }

  parameter {
    name  = "character_set_database"
    value = "utf8mb4"
  }

  parameter {
    name  = "collation_connection"
    value = "utf8mb4_bin"
  }

  parameter {
    name  = "character_set_filesystem"
    value = "utf8mb4"
  }

  parameter {
    name  = "character_set_results"
    value = "utf8mb4"
  }

  parameter {
    # Increase the maximum number of connections to 16000 which is the maximum of aurora DB connection
    name  = "max_connections"
    value = 16000
  }

  parameter {
    apply_method = "pending-reboot"
    name         = "performance_schema"
    value        = "0"
  }

  parameter {
    apply_method = "pending-reboot"
    name         = "query_cache_type"
    value        = "0"
  }

  parameter {
    # Set max connection errors to 999999
    apply_method = "immediate" #  Changes applied immediately
    name         = "max_connect_errors"
    value        = "999999"
  }

  parameter {
    # Enabled audit logging
    apply_method = "immediate"
    name         = "server_audit_logging"
    value        = 1
  }

}
