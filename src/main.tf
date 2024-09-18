# Provedor da AWS
provider "aws" {
  region  = var.region
}

terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.67.0"
    }
  }
}

# Criação do cluster EKS
variable "region" {
  default = "us-east-1"
}

variable "cluster_name" {
  default = "shogun-eks-cluster"
}

resource "aws_eks_cluster" "shogun-eks-cluster" {
  name     = var.cluster_name
  role_arn = "arn:aws:iam::342326109351:instance-profile/LabInstanceProfile"

  vpc_config {
    subnet_ids = ["subnet-08b12ee2b94a5858c", "subnet-0a101f1266c9eac44", "subnet-0b4d0b0ab35c17f9b", "subnet-007d71cbdfb479ac0", "subnet-0c3fe33974de67d07", "subnet-0f31e291536aba412"]
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Cluster handling.
  # Otherwise, EKS will not be able to properly delete EKS managed EC2 infrastructure such as Security Groups.
  depends_on = [
    "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy",
    "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
  ]
}