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

# Cria grupo de segurança VPC
resource "aws_security_group" "shogun_grupo" {
  name        = "Shogun grupo de seguranca"
  description = "Grupo de seguranca dos servicos Shogun"
  vpc_id      = aws_vpc.shogun_vpc.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_vpc_security_group_ingress_rule" "ipv4_shogun" {
  security_group_id = aws_security_group.shogun_grupo.id
  cidr_ipv4         = aws_vpc.shogun_vpc.cidr_block
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}

resource "aws_vpc_security_group_ingress_rule" "ipv4_shogun_base" {
  security_group_id = aws_security_group.shogun_grupo.id
  cidr_ipv4         = aws_vpc.shogun_vpc.cidr_block
  from_port         = 3306
  ip_protocol       = "tcp"
  to_port           = 3306
}


resource "aws_vpc_security_group_egress_rule" "ipv4_shogun" {
  security_group_id = aws_security_group.shogun_grupo.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}