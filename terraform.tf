  provider "aws" {
    region = var.region
    secret_key = var.secret_key
    access_key = var.access_key
  }
  resource "aws_vpc" "myvpc" {
      cidr_block = var.vpc_cidr
      enable_dns_support = "true"
      enable_dns_hostnames = "true"
      tags = {
        "Name" = "myvpc"
      }
  }
  resource "aws_subnet" "public" {
      vpc_id = "$(aws_vpc.myvpc.id)"
      cidr_block = var.public_cidr
      availability_zone = var.public_az
      map_public_ip_on_launch = "true"
      tags = {
        "Name" = "PublicSubnet"
      }
  }
  resource "aws_subnet" "public2" {
      vpc_id = "$(aws_vpc.myvpc.id)"
      cidr_block = var.public_cidr2
      availability_zone = var.public_az2
      map_public_ip_on_launch = "true"
      tags = {
        "Name" = "PublicSubnet2"
      }
  }
  resource "aws_subnet" "private" {
      vpc_id = "$(aws_vpc.myvpc.id)"
      cidr_block = var.private_cidr
      availability_zone = var.private_az
      tags = {
        "Name" = "PrivateSubnet"
      }
  }
  resource "aws_internet_gateway" "igw" {
      vpc_id = "$(aws_vpc.myvpc.id)"
      tags = {
        "Name" = "igw"
      }
  }
  resource "aws_route_table" "public_rt" {
    vpc_id = aws_vpc.myvpc.id
    route {
      cidr_block = "0.0.0.0/0"
      gateway_id = aws_internet_gateway.igw.id
    }
    tags = {
      Name = "publicRouteTable"
    }
  }
  resource "aws_route_table_association" "a" {
    count = length(var.subnets_cidr)
    subnet_id = "{$aws_subnet.public.id}"
    route_table_id = aws_route_table.public_rt.id
  }
  resource "aws_security_group" "mysg" {
      vpc_id = "{$aws_vpc.myvpc.id}"
      ingress {
          from_port = 80
          to_port = 80
          protocol = "tcp"
          cidr_blocks = ["0.0.0.0/0"]
      }
      ingress {
          from_port = 443
          to_port = 443
          protocol = "tcp"
          cidr_blocks = ["0.0.0.0/0"]
      }
      egress {
          from_port = 0
          to_port = 0
          protocol = -1
          cidr_blocks = ["0.0.0.0/0"]
      }
      tags = {
        "Name" = "mysg"
      }
  }
  resource "tls_private_key" "mykey" {
    algorithm = "RSA"
    rsa_bits  = 4096
  }
  resource "aws_key_pair" "myKey" {
    key_name   = "myKey"
    public_key = tls_private_key.mykey.public_key_openssh

    provisioner "local-exec" {
      command = "echo '${tls_private_key.mykey.private_key_pem}' > ./myKey.pem"
    }
  }
  resource "aws_instance" "server" {
      ami = var.ami
      instance_type = var.instance_type
      subnet_id = "{$aws_subnet.public.id}"
      key_name = "{$aws_key_pair.myKey.id}"
      user_data = "${file("apache_config.sh")}"
  }
  resource "aws_security_group" "alb" {
    name        = "my-lb"
    description = "Terraform load balancer security group"
    vpc_id      = "${aws_vpc.myvpc.id}"

    ingress {
      from_port   = 443
      to_port     = 443
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }

    # Allow all outbound traffic.
    egress {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  resource "aws_alb" "alb" {
    name            = "my-lb"
    security_groups = ["${aws_security_group.alb.id}"]
    subnets         = ["{$aws_subnet.public.id}", "{$aws_subnet.public2.id}"]
  }
  resource "aws_alb_target_group" "group" {
    name     = "alb-tgt"
    port     = 80
    protocol = "HTTP"
    vpc_id   = "${aws_vpc.myvpc.id}"
    health_check {
      path = "/"
      port = 80
    }
  }
  resource "aws_alb_listener" "listener_http" {
    load_balancer_arn = "${aws_alb.alb.arn}"
    port              = "80"
    protocol          = "HTTP"

    default_action {
      target_group_arn = "${aws_alb_target_group.group.arn}"
      type             = "forward"
    }
  }