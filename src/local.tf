locals {
  cluster_name = "shogun-cluster-eks"
  region       = "us-east-1"
  lab_role     = "arn:aws:iam::207567779785:role/AmazonEKSAutoClusterRole"
  subnets      = ["subnet-012d440d0217625bd", "subnet-0f5d7d7ae77b9ccba"]
}
