terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
}

provider "aws" {
  region = "ap-northeast-1"
}

resource "aws_vpc" "demo_vpc_01" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "Terraform VPC"
  }
}

resource "aws_subnet" "public_subnet_01" {
  vpc_id     = aws_vpc.demo_vpc_01.id
  cidr_block = "10.0.0.0/24"

  tags = {
    Name = "demo-public-subnet-01"
  }
}

resource "aws_subnet" "private_subnet_01" {
  vpc_id     = aws_vpc.demo_vpc_01.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "demo-private-subnet-01"
  }
}

resource "aws_internet_gateway" "igw_01" {
  vpc_id = aws_vpc.demo_vpc_01.id

  tags = {
    Name = "demo-igw"
  }
}

resource "aws_route_table" "public_rtb_01" {
  vpc_id = aws_vpc.demo_vpc_01.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw_01.id
  }

  tags = {
    Name = "demo-public-route-table"
  }
}

resource "aws_route_table_association" "public_subnet_01" {
  subnet_id      = aws_subnet.public_subnet_01.id
  route_table_id = aws_route_table.public_rtb_01.id
}
