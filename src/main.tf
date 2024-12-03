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
