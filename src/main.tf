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
  name     = var.aws_eks_cluster_name
  role_arn = var.node_role_arn

  vpc_config {
    subnet_ids = [aws_subnet.subnet_1.id, aws_subnet.subnet_2.id, aws_subnet.subnet_3.id, aws_subnet.subnet_4.id, aws_subnet.subnet_5.id]
    security_group_ids = [var.security_group_id]
  }
}

# Cria o node group
resource "aws_eks_node_group" "example" {
  cluster_name    = var.aws_eks_cluster_name
  node_group_name = var.node_group_name
  node_role_arn   = var.node_role_arn
  subnet_ids      = [aws_subnet.subnet_1.id, aws_subnet.subnet_2.id]

  scaling_config {
    desired_size = 1
    max_size     = 2
    min_size     = 1
  }

  update_config {
    max_unavailable = 1
  }
}

# Configura Fargate
resource "aws_eks_fargate_profile" "example" {
  cluster_name           =  var.aws_eks_cluster_name
  fargate_profile_name   = "example"
  pod_execution_role_arn = var.node_role_arn
  subnet_ids             = [aws_subnet.subnet_1.id, aws_subnet.subnet_2.id, aws_subnet.subnet_3.id, aws_subnet.subnet_4.id, aws_subnet.subnet_5.id]

  selector {
    namespace = "shogun"
  }
}