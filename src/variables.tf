variable "aws_region" {
  description = "Região usada para criar os recursos da AWS"
  type = string
  nullable = false
}

variable "aws_vpc_name" {
  description = "Nome da VPC"
  type = string
  nullable = false
}

variable "aws_vpc_cidr" {
  description = "Nome da VPC CIDR"
  nullable = false
}

variable "aws_vpc_azs" {
  description = "Nome da VPC AZS"
  type = set(string)
  nullable = false
}

variable "aws_vpc_private_subnets" {
  description = "Nome das subnets VPC privadas"
  type = set(string)
  nullable = false
}

variable "aws_vpc_public_subnets" {
  description = "Nome das subnets VPC publicas"
  type = set(string)
  nullable = false
}

variable "aws_eks_name" {
  description = "Nome do cluster EKS"
  type = string
  nullable = false
}

variable "aws_eks_version" {
  description = "Versão do EKS"
  type = string
  nullable = false
}

variable "aws_eks_managed_node_groups_instance_types" {
  description = "Grupo de instâncias dos nós"
  type = set(string)
  nullable = false
}

variable "aws_project_tags" {
  description = "Tags do projeto"
  type = map(any)
  nullable = false
}


