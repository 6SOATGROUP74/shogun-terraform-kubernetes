# # # VPC
# # resource "aws_vpc" "shogun_vpc" {
# #   cidr_block       = "172.31.0.0/16"
# #   instance_tenancy = "default"
# #   enable_dns_support   = true
# #   enable_dns_hostnames = true
# # }
#
# # Subnet 1
# resource "aws_subnet" "subnet_1" {
#   vpc_id            = aws_vpc.personalerp_private_vpc.id
#   cidr_block        = "172.31.32.0/20"
#   availability_zone = "us-east-1d"
#   map_public_ip_on_launch = true
# }
#
# # Subnet 2
# resource "aws_subnet" "subnet_2" {
#   vpc_id            = aws_vpc.personalerp_private_vpc.id
#   cidr_block        = "172.31.64.0/20"
#   availability_zone = "us-east-1f"
# }
#
# resource "aws_vpc" "personalerp_private_vpc" {
#   cidr_block = "172.31.0.0/16"
# }
#
# data "aws_availability_zones" "available" {}
#
# resource "aws_subnet" "personalerp-eks-subnet" {
#   count = 3
#   vpc_id                  = aws_vpc.personalerp_private_vpc.id
#   availability_zone       = data.aws_availability_zones.available.names[count.index]
#   cidr_block              = cidrsubnet(aws_vpc.personalerp_private_vpc.cidr_block, 8, count.index)
#   map_public_ip_on_launch = false
# }
#
# resource "aws_internet_gateway" "personalerp_internet_gateway" {
#   vpc_id = aws_vpc.personalerp_private_vpc.id
# }
#
# resource "aws_route_table" "personalerp_route_table" {
#   vpc_id = aws_vpc.personalerp_private_vpc.id
#
#   route {
#     cidr_block = "0.0.0.0/0"
#     gateway_id = aws_internet_gateway.personalerp_internet_gateway.id
#   }
# }
#
# resource "aws_route_table_association" "personalerp_route_table_associacion" {
#   subnet_id      = aws_subnet.personalerp-eks-subnet.*.id[count.index]
#   route_table_id = aws_route_table.personalerp_route_table.id
#   count          = 3
# }