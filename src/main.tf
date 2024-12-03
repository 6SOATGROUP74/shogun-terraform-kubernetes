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
  name                          = local.cluster_name
  role_arn                      = local.lab_role
  bootstrap_self_managed_addons = true

  vpc_config {
    subnet_ids = local.subnets
  }
}

# Cria o node group
resource "aws_eks_node_group" "aws_eks_node_group_shogun" {

  depends_on = [
    aws_eks_cluster.shogun_cluster
  ]

  cluster_name    = local.cluster_name
  node_group_name = "group-shogun"
  node_role_arn   = local.lab_role
  subnet_ids      = local.subnets

  scaling_config {
    desired_size = 3
    max_size     = 4
    min_size     = 3
  }

  update_config {
    max_unavailable = 1
  }

  instance_types = ["t3.medium"]
}