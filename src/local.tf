locals {
  cluster_name = "shogun-cluster-eks"
  region       = "us-east-1"
  lab_role     = "arn:aws:iam::585814035402:role/LabRole"
  subnets      = ["subnet-09b362cc515aa2ca6", "subnet-03325f62d415698e8"]
}
