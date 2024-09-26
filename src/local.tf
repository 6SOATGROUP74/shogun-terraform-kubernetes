locals {
  cluster_name = "shogun-cluster-eks"
  region       = "us-east-1"
  lab_role     = "arn:aws:iam::410052166411:role/LabRole"
  subnets      = ["subnet-05f4c2a96395445af", "subnet-0aef5d2933d2e2e08", "subnet-066203e27e0809e52", "subnet-0cd10b2497a424bc4", "subnet-042e4866f3f5e066f"]
}