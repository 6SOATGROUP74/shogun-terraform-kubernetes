locals {
  cluster_name = "shogun-cluster-eks"
  region       = "us-east-1"
  lab_role     = "arn:aws:iam::410052166411:role/LabRole"
  subnets      = ["subnet-0d18e76cc85fb2e41", "subnet-03a92073745b1f361"]
}
