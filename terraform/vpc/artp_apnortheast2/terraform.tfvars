aws_region = "ap-northeast-2"

# Production CIDR should be different from dev
cidr_numeral = "20"

# Please change "art" to what you want to use
# p after name indicates production. This means that artp_apnortheast2 VPC is for production environment VPC in Seoul Region.
vpc_name = "artp_apnortheast2"

# Billing tag in this VPC 
billing_tag = "prod"

# Availability Zone list
availability_zones = ["ap-northeast-2a", "ap-northeast-2c", "ap-northeast-2b"]

# In Seoul Region, some resources are not supported in ap-northeast-2b
availability_zones_without_b = ["ap-northeast-2a", "ap-northeast-2c"]

# shard_id will be used later when creating other resources.
# With shard_id, you could distinguish which environment the resource belongs to 
shard_id       = "artpapne2"
shard_short_id = "art01p"

# p means production
env_suffix = "p"

# VPC Peering Connection Variables
vpc_peer_connection_id_artd_apne2 = "pcx-"
artd_destination_cidr_block       = "10.10.0.0/16"

vpc_peering_list = {
  artd_apnortheast2 = {
    peer_vpc_id   = "vpc-"
    peer_owner_id = ""
    peer_region   = "ap-northeast-2"
    peer_vpc_name = "artd_apnortheast2"
    vpc_cidr      = "10.10.0.0/16"
  }
}
