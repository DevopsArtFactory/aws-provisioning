resource "aws_eks_cluster" "eks_cluster" {
  name     = var.cluster_name
  role_arn = aws_iam_role.eks_cluster.arn
  version  = var.cluster_version

  vpc_config {
    security_group_ids      = [aws_security_group.eks_cluster.id]
    subnet_ids              = var.cluster_subnet_ids
    endpoint_private_access = true
    endpoint_public_access  = var.enable_public_access
    public_access_cidrs     = var.public_access_cidrs
  }

  kubernetes_network_config {
    service_ipv4_cidr = var.service_ipv4_cidr
  }
  tags = merge(var.tags, tomap({
    "Name" = var.cluster_name,
  }))

  depends_on = [
    aws_iam_role_policy_attachment.eks_cluster_AmazonEKSClusterPolicy,
  ]
}


resource "aws_security_group" "eks_cluster" {
  name        = "eks-${var.cluster_name}-cluster-sg"
  description = "Cluster communication with Worker Nodes"
  vpc_id      = var.target_vpc

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = []
    self        = true
    description = ""
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "TCP"
    cidr_blocks = ["10.112.0.0/16"]
  }

  dynamic "ingress" {
    for_each = var.additional_security_group_ingress
    content {
      from_port       = ingress.value["from_port"]
      to_port         = ingress.value["to_port"]
      protocol        = ingress.value["protocol"]
      cidr_blocks     = ingress.value["cidr_blocks"]
      security_groups = ingress.value["security_groups"]
    }
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
    description      = ""
  }

  tags = merge(var.tags, tomap({
    "Name"                                      = "eks-${var.cluster_name}-cluster-sg",
    "kubernetes.io/cluster/${var.cluster_name}" = "owned"
  }))
}


# IAM
resource "aws_iam_role" "eks_cluster" {
  name               = "eks-${var.cluster_name}"
  description        = "Allows access to other AWS service resources that are required to operate clusters managed by EKS."
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

data "aws_iam_policy_document" "assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["eks.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }

  dynamic "statement" {
    for_each = var.cluster_policy_list
    content {
      effect = "Allow"
      principals {
        type        = statement.value.type
        identifiers = statement.value.identifier
      }
      actions = ["sts:AssumeRole"]
    }
  }
}

resource "aws_iam_role_policy_attachment" "eks_cluster_AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks_cluster.name
}

resource "aws_iam_role_policy_attachment" "eks_cluster_AmazonEKSVPCResourceController" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
  role       = aws_iam_role.eks_cluster.name
}
