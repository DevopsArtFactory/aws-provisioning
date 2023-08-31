# Basic Information
account_alias = "id"
product       = "lgu"

# Cluster information
cluster_version = "1.27"

# Addon information
# https://docs.aws.amazon.com/ko_kr/eks/latest/userguide/managing-coredns.html
coredns_version            = "v1.10.1-eksbuild.2"

# https://docs.aws.amazon.com/ko_kr/eks/latest/userguide/managing-kube-proxy.html
kube_proxy_version         = "v1.27.1-eksbuild.1"

# https://docs.aws.amazon.com/ko_kr/eks/latest/userguide/managing-vpc-cni.html
vpc_cni_version            = "v1.13.2-eksbuild.1"

# https://github.com/kubernetes-sigs/aws-ebs-csi-driver
aws_ebs_csi_driver_version = "v1.21.0-eksbuild.1"

# Managed Node Group inforation
# https://github.com/awslabs/amazon-eks-ami/releases
node_group_release_version = "1.27.4-20230825"

# Fargate Information
fargate_enabled      = false
fargate_profile_name = ""

# access
enable_public_access = true
additional_ingress = []

# Node Group configuration
node_group_configurations = [
  {
    name                = "ondemand"
    spot_enabled        = false
    disk_size           = 20
    ami_type            = "AL2_x86_64"
    node_instance_types = ["t3.large"]
    node_min_size       = 2
    node_desired_size   = 2
    node_max_size       = 10
    labels = {
      "cpu_chip" = "intel"
    }
  },
  {
    name                = "spot"
    spot_enabled        = true
    disk_size           = 20
    ami_type            = "AL2_x86_64"
    node_instance_types = ["t3.medium"]
    node_min_size       = 3
    node_desired_size   = 3
    node_max_size       = 10
    labels = {
      "cpu_chip" = "intel"
    }
  }
]

# Cluster Access
aws_auth_master_roles_arn = []

aws_auth_master_users_arn = []

aws_auth_viewer_roles_arn = []

aws_auth_viewer_users_arn = [
  "arn:aws:iam::816736805842:user/gslee",
  "arn:aws:iam::816736805842:user/jupiter.song",
  "arn:aws:iam::816736805842:user/zerojin0312",
]
