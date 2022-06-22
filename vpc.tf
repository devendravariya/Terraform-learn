resource "aws_vpc" "devendra" {
  cidr_block = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support = true
}
resource "aws_subnet" "public" {
  count = length(var.subnets_cidr)
  vpc_id = aws_vpc.devendra.id
  cidr_block = element(var.subnets_cidr,count.index)
  availability_zone = element(var.azs,count.index)
  map_public_ip_on_launch = true
  tags = {
    Name = "Subnet-${count.index+1}"
  }
}
resource "aws_internet_gateway" "terra_igw" {
  vpc_id = aws_vpc.devendra.id
}
resource "aws_route_table" "public_rt" {
  vpc_id = "${aws_vpc.devendra.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.terra_igw.id}"
  }
}
resource "aws_route_table_association" "join" {
  vpc_id = aws_vpc.devendra.id
  route_table_id = aws_route_table.public_rt.id
  subnet_id = element(aws_subnet.public.*.id,count.index)
  count = length(var.subnets_cidr)
}