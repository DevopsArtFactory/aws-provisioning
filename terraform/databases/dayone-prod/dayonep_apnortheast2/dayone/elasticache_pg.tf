# Elasticache Parameter Group for redis
resource "aws_elasticache_parameter_group" "dayone_redis_cluster_pg" {
  name        = "dayone-cluster-${data.terraform_remote_state.vpc.outputs.shard_id}"
  description = "dayone Elasticache Redis Parameter Group"

  # Please use the right engine and version
  family = "redis5.0"

  # List of cluster parameters
  parameter {
    name  = "cluster-enabled"
    value = "yes"
  }

  parameter {
    name  = "slowlog-log-slower-than"
    value = "50000"
  }

  parameter {
    name  = "lazyfree-lazy-eviction"
    value = "yes"
  }

  parameter {
    name  = "lazyfree-lazy-expire"
    value = "yes"
  }

  parameter {
    name  = "lazyfree-lazy-server-del"
    value = "yes"
  }

  parameter {
    name  = "active-defrag-cycle-max"
    value = "75"
  }
  parameter {
    name  = "active-defrag-cycle-min"
    value = "5"
  }
  parameter {
    name  = "active-defrag-ignore-bytes"
    value = "104857600"
  }
  parameter {
    name  = "active-defrag-max-scan-fields"
    value = "1000"
  }
  parameter {
    name  = "active-defrag-threshold-lower"
    value = "10"
  }
  parameter {
    name  = "active-defrag-threshold-upper"
    value = "100"
  }
  parameter {
    name  = "activedefrag"
    value = "no"
  }
  parameter {
    name  = "client-output-buffer-limit-normal-hard-limit"
    value = "0"
  }
  parameter {
    name  = "client-output-buffer-limit-normal-soft-limit"
    value = "0"
  }
  parameter {
    name  = "client-output-buffer-limit-normal-soft-seconds"
    value = "0"
  }
  parameter {
    name  = "client-output-buffer-limit-pubsub-hard-limit"
    value = "33554432"
  }
  parameter {
    name  = "client-output-buffer-limit-pubsub-soft-limit"
    value = "8388608"
  }
  parameter {
    name  = "client-output-buffer-limit-pubsub-soft-seconds"
    value = "60"
  }
  parameter {
    name  = "client-query-buffer-limit"
    value = "1073741824"
  }
  parameter {
    name  = "close-on-replica-write"
    value = "yes"
  }
  parameter {
    name  = "cluster-require-full-coverage"
    value = "no"
  }
  parameter {
    name  = "hash-max-ziplist-entries"
    value = "512"
  }
  parameter {
    name  = "hash-max-ziplist-value"
    value = "64"
  }
  parameter {
    name  = "hll-sparse-max-bytes"
    value = "3000"
  }

  parameter {
    name  = "lfu-decay-time"
    value = "1"
  }
  parameter {
    name  = "lfu-log-factor"
    value = "10"
  }
  parameter {
    name  = "list-compress-depth"
    value = "0"
  }
  parameter {
    name  = "lua-replicate-commands"
    value = "yes"
  }
  parameter {
    name  = "maxmemory-policy"
    value = "volatile-lru"
  }
  parameter {
    name  = "maxmemory-samples"
    value = "3"
  }
  parameter {
    name  = "min-replicas-max-lag"
    value = "10"
  }
  parameter {
    name  = "min-replicas-to-write"
    value = "0"
  }
  parameter {
    name  = "proto-max-bulk-len"
    value = "536870912"
  }
  parameter {
    name  = "repl-backlog-size"
    value = "1048576"
  }
  parameter {
    name  = "repl-backlog-ttl"
    value = "3600"
  }
  parameter {
    name  = "reserved-memory-percent"
    value = "25"
  }
  parameter {
    name  = "set-max-intset-entries"
    value = "512"
  }
  parameter {
    name  = "slowlog-max-len"
    value = "128"
  }
  parameter {
    name  = "stream-node-max-bytes"
    value = "4096"
  }
  parameter {
    name  = "stream-node-max-entries"
    value = "100"
  }
  parameter {
    name  = "tcp-keepalive"
    value = "300"
  }
  parameter {
    name  = "timeout"
    value = "0"
  }
  parameter {
    name  = "zset-max-ziplist-entries"
    value = "128"
  }
  parameter {
    name  = "zset-max-ziplist-value"
    value = "64"
  }
  parameter {
    name  = "rename-commands"
    value = ""
  }
}
