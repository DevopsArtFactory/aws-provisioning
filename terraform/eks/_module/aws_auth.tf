locals {
  auth_master_roles = {
    "system:masters" = var.aws_auth_master_roles_arn
  }
  auth_master_users = {
    "system:masters" = var.aws_auth_master_users_arn
  }
  auth_viewer_roles = {
    "viewers" = var.aws_auth_viewer_roles_arn
  }
  auth_viewer_users = {
    "viewers" = var.aws_auth_viewer_users_arn
  }
  auth_additional_roles = var.auth_additional_roles_arn
}

data "aws_eks_cluster_auth" "eks_auth" {
  name       = "aws_eks_cluster.eks_cluster"
  depends_on = [aws_eks_cluster.eks_cluster]
}

resource "kubernetes_config_map" "aws_auth" {
  depends_on = [aws_eks_cluster.eks_cluster]

  metadata {
    namespace = "kube-system"
    name      = "aws-auth"
  }

  data = {
    mapRoles = yamlencode(
      concat(
        [
          {
            rolearn  = aws_iam_role.eks_node_group.arn
            username = "system:node:{{EC2PrivateDNSName}}"
            groups = [
              "system:bootstrappers",
              "system:nodes",
            ]
          },
        ],
        flatten(
          [for group, roles in local.auth_master_roles :
            [for role in roles :
              {
                rolearn  = role
                username = split("/", role)[1]
                groups   = [group]
              }
            ]
          ]
        ),
        length(local.auth_viewer_roles) > 0 ?
        flatten(
          [for group, roles in local.auth_viewer_roles :
            [for role in roles :
              {
                rolearn  = role
                username = split("/", role)[1]
                groups   = [group]
              }
            ]
          ]
        ) : [],
        length(local.auth_additional_roles) > 0 ?
        flatten(
          [for role in var.auth_additional_roles_arn :
            {
              rolearn  = role.role_arn
              username = role.username
              groups   = role.groups
            }
          ]
        ) : [],
        var.fargate_enable ? [
          {
            rolearn  = aws_iam_role.eks_fargate[0].arn
            username = "system:node:{{SessionName}}"
            groups = [
              "system:bootstrappers",
              "system:nodes",
              "system:node-proxier",
            ]
          },
        ] : []
      )
    ),

    mapUsers = yamlencode(
      concat(
        length(local.auth_master_users) > 0 ?
        flatten(
          [for group, users in local.auth_master_users :
            [for user in users :
              {
                userarn  = user
                username = split("/", user)[1]
                groups   = [group]
              }
            ]
          ]
        ) : [],
        length(local.auth_viewer_users) > 0 ?
        flatten(
          [for group, users in local.auth_viewer_users :
            [for user in users :
              {
                userarn  = user
                username = split("/", user)[1]
                groups   = [group]
              }
            ]
          ]
        ) : []
      )
    )
  }
}

resource "kubernetes_cluster_role_binding" "viewers" {
  metadata {
    name = "viewers"
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "view"
  }

  subject {
    kind      = "Group"
    name      = "viewers"
    api_group = "rbac.authorization.k8s.io"
    namespace = "-"
  }
}
