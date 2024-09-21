# VPC
resource "aws_vpc" "shogun_vpc" {
  cidr_block       = "172.31.0.0/16"
  instance_tenancy = "default"
}

# Subnet 1
resource "aws_subnet" "subnet_1" {
  vpc_id            = aws_vpc.shogun_vpc.id
  cidr_block        = "172.31.0.0/20"
  availability_zone = "us-east-1a"
}

# Subnet 2
resource "aws_subnet" "subnet_2" {
  vpc_id            = aws_vpc.shogun_vpc.id
  cidr_block        = "172.31.80.0/20"
  availability_zone = "us-east-1b"
}

# Subnet 3
resource "aws_subnet" "subnet_3" {
  vpc_id     = aws_vpc.shogun_vpc.id
  cidr_block = "172.31.32.0/20"
  availability_zone = "us-east-1c"
}

# Subnet 4
resource "aws_subnet" "subnet_4" {
  vpc_id     = aws_vpc.shogun_vpc.id
  cidr_block = "172.31.64.0/20"
  availability_zone = "us-east-1e"
}

# Subnet 5
resource "aws_subnet" "subnet_5" {
  vpc_id     = aws_vpc.shogun_vpc.id
  cidr_block = "172.31.16.0/20"
  availability_zone = "us-east-1f"
}