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

# Cria o cluster do EKS
resource "aws_eks_cluster" "shogun_cluster" {
  name     = var.aws_eks_cluster_name
  role_arn = var.node_role_arn

  vpc_config {
    subnet_ids         = [aws_subnet.subnet_1.id, aws_subnet.subnet_2.id]
    security_group_ids = [aws_security_group.shogun_grupo.id]
  }
}

resource "aws_iam_role" "fargate_shogun_role" {
  name = "fargate_shogun_role"

  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "eks-fargate-pods.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
}

resource "aws_iam_role_policy_attachment" "shogun-AmazonEKSFargatePodExecutionRolePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSFargatePodExecutionRolePolicy"
  role       = aws_iam_role.fargate_shogun_role.name
}

# Configura Fargate
resource "aws_eks_fargate_profile" "eks_fargate" {

  depends_on = [
    aws_eks_cluster.shogun_cluster
  ]

  cluster_name           = var.aws_eks_cluster_name
  fargate_profile_name   = var.fargate_name
  pod_execution_role_arn = aws_iam_role.fargate_shogun_role.arn
  subnet_ids             = [aws_subnet.subnet_1.id, aws_subnet.subnet_2.id]

  selector {
    namespace = "shogun"
  }
}

# Roles do node group
resource "aws_iam_role" "eks_shogun_node_group" {
  name = "eks_shogun_node_group"

  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
    }]
    Version = "2012-10-17"
  })
}

resource "aws_iam_role_policy_attachment" "shogun-AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.eks_shogun_node_group.name
}

resource "aws_iam_role_policy_attachment" "shogun-AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.eks_shogun_node_group.name
}

resource "aws_iam_role_policy_attachment" "shogun-AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.eks_shogun_node_group.name
}

# Cria o node group
resource "aws_eks_node_group" "aws_eks_node_group_shogun" {

  depends_on = [
    aws_eks_cluster.shogun_cluster, aws_eks_fargate_profile.eks_fargate
  ]

  cluster_name    = var.aws_eks_cluster_name
  node_group_name = var.node_group_name
  node_role_arn   = aws_iam_role.eks_shogun_node_group.arn
  subnet_ids      = [aws_subnet.subnet_1.id, aws_subnet.subnet_2.id]

  scaling_config {
    desired_size = 1
    max_size     = 4
    min_size     = 1
  }

instance_types = ["t3.medium"]
}