locals {
  cluster_name = "shogun-cluster-eks"
  region       = "us-east-1"
  lab_role     = "arn:aws:iam::410052166411:role/LabRole"
  subnets      = ["subnet-0810ce034a02029e6", "subnet-02c86ce1789576174", "subnet-050b839406c2f3629", "subnet-0bf65a105d8b18d1b"]
}
