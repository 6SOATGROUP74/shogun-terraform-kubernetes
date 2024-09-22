# VPC
resource "aws_vpc" "shogun_vpc" {
  cidr_block       = "172.31.0.0/16"
  instance_tenancy = "default"
  enable_dns_support   = true
  enable_dns_hostnames = true
}

# Subnet 1
resource "aws_subnet" "subnet_1" {
  vpc_id            = aws_vpc.shogun_vpc.id
  cidr_block        = "172.31.0.0/20"
  availability_zone = "us-east-1a"
  map_public_ip_on_launch = true
}

# Subnet 2
resource "aws_subnet" "subnet_2" {
  vpc_id            = aws_vpc.shogun_vpc.id
  cidr_block        = "172.31.80.0/20"
  availability_zone = "us-east-1b"
}

resource "aws_internet_gateway" "shogun_gateway" {
  vpc_id = aws_vpc.shogun_vpc.id
}