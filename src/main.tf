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

# Cria o node group
resource "aws_eks_node_group" "aws_eks_node_group_shogun" {

  depends_on = [
    aws_eks_cluster.shogun_cluster
  ]

  cluster_name    = var.aws_eks_cluster_name
  node_group_name = var.node_group_name
  node_role_arn   = var.node_role_arn
  subnet_ids = ["subnet-0b4d0b0ab35c17f9b", "subnet-0c3fe33974de67d07"]
  ami_type = "AL2_x86_64"

  scaling_config {
    desired_size = 1
    max_size     = 4
    min_size     = 1
  }

  update_config {
    max_unavailable = 1
  }

  instance_types = ["t3.medium"]
}