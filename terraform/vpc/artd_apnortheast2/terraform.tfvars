aws_region   = "ap-northeast-2"
cidr_numeral = "10"

# Please change "art" to what you want to use
# d after name indicates develop. This means that artd_apnortheast2 VPC is for development environment VPC in Seoul Region.
vpc_name = "artd_apnortheast2"

# Billing tag in this VPC 
billing_tag = "dev"

# Availability Zone list
availability_zones = ["ap-northeast-2a", "ap-northeast-2c"]

# In Seoul Region, some resources are not supported in ap-northeast-2b
availability_zones_without_b = ["ap-northeast-2a", "ap-northeast-2c"]

# shard_id will be used later when creating other resources.
# With shard_id, you could distinguish which environment the resource belongs to 
shard_id       = "artdapne2"
shard_short_id = "art01d"

# d means develop
env_suffix = "d"
