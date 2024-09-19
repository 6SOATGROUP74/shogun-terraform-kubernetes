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

}
