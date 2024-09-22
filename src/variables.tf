variable "node_role_arn" {
  type      = string
  sensitive = true
}

variable "aws_eks_cluster_name" {
  type    = string
  default = "shogun_cluster"
}

variable "node_group_name" {
  type    = string
  default = "shogun_node_group"
}

variable "fargate_name" {
  type    = string
  default = "shogun_fargate"
}

data "aws_vpc" "vpc_1" {
  id = "vpc-0b6999a749aa16d63"
}

data "aws_subnet" "subnet_1" {
  id = "subnet-0b4d0b0ab35c17f9b"
}

data "aws_subnet" "subnet_2" {
  id = "subnet-0c3fe33974de67d07"
}