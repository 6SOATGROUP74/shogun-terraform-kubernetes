# Provedor da AWS
provider "aws" {
  region = "us-east-1"
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.67.0"
    }
  }
}

#  Criando o security group que sera atribuido ao cluster limitando o acesso somente da rede interna
resource "aws_security_group" "shogun_cluster" {
  name        = "terraform_cluster"
  description = "AWS security group for terraform"
  vpc_id      = data.aws_vpc.vpc_1.id

  # Input
  ingress {
    from_port   = "1"
    to_port     = "65365"
    protocol    = "TCP"
    cidr_blocks = concat(data.aws_subnet.subnet_1[*].cidr_block, data.aws_subnet.subnet_2[*].cidr_block, [data.aws_vpc.vpc_1.cidr_block])
  }

  # Output
  egress {
    from_port   = 0             # any port
    to_port     = 0             # any port
    protocol    = "-1"          # any protocol
    cidr_blocks = ["0.0.0.0/0"] # any destination
  }

  # ICMP Ping
  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = concat(data.aws_subnet.subnet_1[*].cidr_block, data.aws_subnet.subnet_2[*].cidr_block, [data.aws_vpc.vpc_1.cidr_block])
  }
}

# Cria o cluster do EKS
resource "aws_eks_cluster" "shogun_cluster" {
  name     = var.aws_eks_cluster_name
  role_arn = var.node_role_arn

  vpc_config {
    subnet_ids         = [data.aws_subnet.subnet_1.id, data.aws_subnet.subnet_2.id]
    security_group_ids = [aws_security_group.shogun_cluster.id]
  }
}

# Configura Fargate
resource "aws_eks_fargate_profile" "eks_fargate" {

  depends_on = [
    aws_eks_cluster.shogun_cluster
  ]

  cluster_name           = var.aws_eks_cluster_name
  fargate_profile_name   = var.fargate_name
  pod_execution_role_arn = var.node_role_arn
  subnet_ids             = [data.aws_subnet.subnet_1.id, data.aws_subnet.subnet_2.id]

  selector {
    namespace = "shogun"
  }
}

# Cria o node group
resource "aws_eks_node_group" "aws_eks_node_group_shogun" {

  depends_on = [
    aws_eks_cluster.shogun_cluster, aws_eks_fargate_profile.eks_fargate
  ]

  cluster_name    = var.aws_eks_cluster_name
  node_group_name = var.node_group_name
  node_role_arn   = var.node_role_arn
  subnet_ids      = [data.aws_subnet.subnet_1.id, data.aws_subnet.subnet_2.id]

  scaling_config {
    desired_size = 1
    max_size     = 4
    min_size     = 1
  }

  update_config {
    max_unavailable = 1
  }

  instance_types = ["t3.medium"]
}