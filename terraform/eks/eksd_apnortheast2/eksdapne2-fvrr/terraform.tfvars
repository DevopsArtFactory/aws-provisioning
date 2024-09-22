# Basic Information
account_alias = "id"
product       = "eks"

# Cluster information
cluster_version = "1.30"
release_version = "1.30.4-20240917"

# Service CIDR
service_ipv4_cidr = "172.20.0.0/16"

# Addon information
# https://docs.aws.amazon.com/eks/latest/userguide/managing-coredns.html
coredns_version = "v1.11.1-eksbuild.9"

# https://docs.aws.amazon.com/eks/latest/userguide/managing-kube-proxy.html
kube_proxy_version = "v1.30.0-eksbuild.3"

# https://docs.aws.amazon.com/eks/latest/userguide/managing-vpc-cni.html
vpc_cni_version = "v1.18.3-eksbuild.1"

# https://github.com/kubernetes-sigs/aws-ebs-csi-driver
ebs_csi_driver_version = "v1.34.0-eksbuild.1"

# https://github.com/aws/eks-pod-identity-agent
pod_identity_agent_version = "v1.3.2-eksbuild.2"

# Enable Public Access
enable_public_access = true

# Fargate Information
fargate_enabled      = false
fargate_profile_name = ""

# Node Group configuration
node_group_configurations = [
  {
    name                = "ondemand_1_30_4-20240917"
    spot_enabled        = false
    release_version     = "1.30.4-20240917"
    disk_size           = 20
    ami_type            = "AL2023_x86_64_STANDARD"
    node_instance_types = ["t3.large"]
    node_min_size       = 2
    node_desired_size   = 2
    node_max_size       = 2
    labels = {
      "cpu_chip" = "intel"
    }
  },
  {
    name                = "spot_1_30_4-20240917"
    spot_enabled        = true
    disk_size           = 20
    release_version     = "1.30.4-20240917"
    ami_type            = "AL2023_x86_64_STANDARD"
    node_instance_types = ["t3.large"]
    node_min_size       = 2
    node_desired_size   = 2
    node_max_size       = 10
    labels = {
      "cpu_chip" = "intel"
    }
  },
]

additional_security_group_ingress = [
  {
    from_port   = 443
    to_port     = 443
    protocol    = "TCP"
    cidr_blocks = ["10.10.0.0/16"]
  }
]

aws_auth_master_users_arn = [
  "arn:aws:iam::816736805842:user/jupiter.song",
  "arn:aws:iam::816736805842:user/zerojin0312"
]

# Cluster Access
aws_auth_master_roles_arn = [
]

aws_auth_viewer_roles_arn = [

]

# Specified KMS ARNs accessed by ExternalSecrets
external_secrets_access_kms_arns = [
  "*"
]

# Specified SSM ARNs accessed by ExternalSecrets
external_secrets_access_ssm_arns = [
  "*"
]

# Specified SecretsManager ARNs accessed by ExternalSecrets
external_secrets_access_secretsmanager_arns = [
  "*"
]
