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

variable "node_role_arn" {
  type      = string
  sensitive = true
}

resource "aws_eks_cluster" "shogun" {
  name     = "shogun_cluster"
  role_arn = var.node_role_arn


  vpc_config {
    subnet_ids = ["us-east-1a", "us-east-1b", "us-east-1c", "us-east-1d", "us-east-1e", "us-east-1f"]
  }
}
