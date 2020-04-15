aws_region = "ap-northeast-2"
cidr_numeral = "10"

# Please change "dayone" to what you want to use
# d after name indicates develop. This means that dayoned_apnortheast2 VPC is for development environment VPC in Seoul Region.
vpc_name = "dayoned_apnortheast2"

# Billing tag in this VPC 
billing_tag = "dev"

# Availability Zone list
availability_zones = ["ap-northeast-2a","ap-northeast-2c","ap-northeast-2b"]

# In Seoul Region, some resources are not supported in ap-northeast-2b
availability_zones_without_b = ["ap-northeast-2a","ap-northeast-2c"]

# shard_id will be used later when creating other resources.
# With shard_id, you could distinguish which environment the resource belongs to 
shard_id = "dayonedapne2"
shard_short_id = "dayone01d"

# d means develop
env_suffix = "d"

# Peering Connection ID to dayonep_apnortheast2 VPC
#vpc_peer_connection_id_dayonep_apne2 = ""
