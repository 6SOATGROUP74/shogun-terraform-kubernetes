variable "node_role_arn" {
  type      = string
  sensitive = true
  default   = "arn:aws:iam::410052166411:role/LabRole"
}

variable "aws_eks_cluster_name" {
  type    = string
  default = "shogun_cluster"
}

variable "node_group_name" {
  type    = string
  default = "shogun_node_group"
}