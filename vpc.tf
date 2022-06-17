resource "aws_vpc" "terraform_vpc" {
    cidr_block = var.vpc_cidr
    enable_dns_hostnames = true
    enable_dns_support = true
    tags = {
      "Name" = "terraformvpc"
    }
}

resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.terraform_vpc.id
  
}

resource "aws_subnet" "public_subnet" {
    vpc_id = aws_vpc.terraform_vpc.id
    cidr_block = var.public_cidr
    map_public_ip_on_launch = true
    availability_zone = "ap-south-1a"
}
resource "aws_subnet" "private_subnet" {
    vpc_id = aws_vpc.terraform_vpc.id
    cidr_block = var.private_cidr
    map_public_ip_on_launch = true
    availability_zone = "ap-south-1b"
}
resource "aws_route_table" "PublicRT" {
    vpc_id = aws_vpc.terraform_vpc.id
    route {
      cidr_block = "0.0.0.0/0"
      gateway_id = "${aws_internet_gateway.igw.id}"
  }
}
resource "aws_route_table" "PrivateRT" {
  vpc_id = aws_vpc.terraform_vpc.id
  route {
      cidr_block = "192.168.0.0/16"
  }
}