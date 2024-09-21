variable "node_role_arn" {
  type      = string
  sensitive = true
}

variable "aws_eks_cluster_name" {
  type    = string
  default = "shogun_cluster"
}

variable "security_group_id" {
  type    = string
  default = "sgr-0aff9a2bbf2bc8a80"
}

variable "node_group_name" {
  type    = string
  default = "shogun_node_group"
}

variable "fargate_name" {
  type    = string
  default = "shogun_fargate"
}