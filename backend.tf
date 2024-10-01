terraform {
  backend "s3" {
    bucket = "backend-terraform-shogun"
    key = "k8s/terraform.tfstate"
    region = "us-east-1"
  }
}