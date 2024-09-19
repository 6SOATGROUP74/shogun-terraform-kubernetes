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
    subnet_ids = ["subnet-08b12ee2b94a5858c", "subnet-0a101f1266c9eac44", "subnet-0b4d0b0ab35c17f9b", "subnet-0c3fe33974de67d07", "subnet-0f31e291536aba412"]
    security_group_ids = ["sg-0c5ae984e06c36361"]
  }
}
