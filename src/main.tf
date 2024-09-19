resource "aws_eks_cluster" "shogun" {
  name     = "shogun_cluster"
  role_arn = ["arn:aws:iam::342326109351:role/LabRole"]

  vpc_config {
    subnet_ids = ["us-east-1a", "us-east-1b", "us-east-1c", "us-east-1d", "us-east-1e", "us-east-1f"]
  }
}