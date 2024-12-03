terraform {
  backend "s3" {
    bucket = "backend-terraform-shogun-fiap"
    key = "k8s/terraform.tfstate"
    region = "us-east-1"
  }
}