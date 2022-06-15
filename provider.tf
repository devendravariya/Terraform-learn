provider "aws" {
  region = "ap-south-1"
}
resource "aws_vpc" "vpc" {
  cidr_block = "192.168.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support = true
  tags = {
    Name = terraform-vpc
  }
}
resource "aws_subnet" "public-subnet" {
  vpc_id = aws_vpc.vpc.id
  availability_zone = "ap-south-1a"
  cidr_block = "192.168.0.0/24"
  map_public_ip_on_launch = true
  tags = {
    Name = public-subnet
  }
}
resource "aws_subnet" "private-subnet" {
  vpc_id = aws_vpc.vpc.id
  availability_zone = "ap-south-2b"
  cidr_block = "192.168.12.0/24"
  tags = {
    Name = "private-subnet"
  }
}
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
}