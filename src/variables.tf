variable "node_role_arn" {
  type      = string
  sensitive = true
}

variable "aws_eks_cluster_name" {
  type = string
  default = "shogun_cluster"
}

variable "security_group_id" {
  type = string
  default = "sg-0c5ae984e06c36361"
}

variable "node_group_name" {
  type = string
  default = "shogun_node_group"
}