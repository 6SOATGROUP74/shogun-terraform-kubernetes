aws_region = "us-east-1"
aws_vpc_name = "shogun-vpc"
aws_vpc_cidr = "172.31.0.0/16"
aws_vpc_azs = ["us-east-1a", "us-east-1b", "us-east-1c", "us-east-1d", "us-east-1e", "us-east-1f"]
aws_vpc_public_subnets = ["172.31.0.0/20", "172.31.80.0/20", "172.31.32.0/20", "172.31.48.0/20", "172.31.64.0/20", "172.31.16.0/20"]
aws_eks_name = "shogun-cluster"
aws_eks_version = "1.29"
aws_eks_managed_node_groups_instance_types = ["t3.small"]
aws_project_tags = {
  Terraform = "true"
  Environment = "dev"
  Project = "shogun"
  Teste = "ok"
}
