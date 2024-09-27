locals {
  cluster_name = "shogun-cluster-eks"
  region       = "us-east-1"
  lab_role     = "arn:aws:iam::410052166411:role/LabRole"
  subnets      = ["subnet-010445725372fdb32", "subnet-0b1b7a05fcc548e5c", "subnet-08a0ce5e8a4369bae", "subnet-0e4562aab54ef4cc2", "subnet-0a6e5e17341adbfef"]
}