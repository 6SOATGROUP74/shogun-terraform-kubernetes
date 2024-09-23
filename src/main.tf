# Provedor da AWS
provider "aws" {
  region = "us-east-1"
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.67.0"
    }
  }
}

# Cria o cluster do EKS
resource "aws_eks_cluster" "shogun_cluster" {
  name                          = var.aws_eks_cluster_name
  role_arn                      = var.node_role_arn
  bootstrap_self_managed_addons = true

  vpc_config {
    subnet_ids = ["subnet-0b4d0b0ab35c17f9b", "subnet-0c3fe33974de67d07"]
  }
}

# Configura Fargate
resource "aws_eks_fargate_profile" "eks_fargate" {

  depends_on = [
    aws_eks_cluster.shogun_cluster
  ]

  cluster_name           = var.aws_eks_cluster_name
  fargate_profile_name   = var.fargate_name
  pod_execution_role_arn = var.node_role_arn
  subnet_ids = ["subnet-0b4d0b0ab35c17f9b", "subnet-0c3fe33974de67d07"]

  selector {
    namespace = "app-pod"
  }
}

# # Adiciona recursos para gerenciar o cluster
# resource "aws_eks_addon" "addons" {
#   for_each                    = {for addon in var.addons : addon.name => addon}
#   cluster_name                = aws_eks_cluster.shogun_cluster.name
#   addon_name                  = each.value.name
#   addon_version               = each.value.version
#   resolve_conflicts_on_create = "OVERWRITE"
#   service_account_role_arn    = var.node_role_arn
#
#   depends_on = [
#     aws_eks_cluster.shogun_cluster,
#     aws_eks_fargate_profile.eks_fargate
#   ]
# }
#
# variable "addons" {
#   type = list(object({
#     name    = string
#     version = string
#   }))
#   default = [
#     {
#       name    = "kube-proxy"
#       version = "v1.30.0-eksbuild.3"
#     },
#     {
#       name    = "vpc-cni"
#       version = "v1.18.3-eksbuild.3"
#     },
#     {
#       name    = "coredns"
#       version = "v1.11.1-eksbuild.9"
#     }
#   ]
# }

# # Cria o node group
# resource "aws_eks_node_group" "aws_eks_node_group_shogun" {
#
#   depends_on = [
#     aws_eks_cluster.shogun_cluster, aws_eks_fargate_profile.eks_fargate
#   ]
#
#   cluster_name    = var.aws_eks_cluster_name
#   node_group_name = var.node_group_name
#   node_role_arn   = var.node_role_arn
#   subnet_ids      = [aws_subnet.subnet_1.id, aws_subnet.subnet_2.id]
#
#   scaling_config {
#     desired_size = 1
#     max_size     = 4
#     min_size     = 1
#   }
#
#   update_config {
#     max_unavailable = 1
#   }
#
#   instance_types = ["t3.medium"]
# }