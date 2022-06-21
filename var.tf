variable "region" {
    description = "Default Region"
    default = "ap-south-1"
}
variable "secret_key" {
    description = "secrect_key"
    default = ""
}
variable "access_key" {
    description = "access key"
    default = ""
}
variable "vpc_cidr" {
    description = "vpc_cidr"
    default = "192.168.0.0/16"
}
variable "public_cidr" {
    description = "public cidr"
    default = "192.168.0.0/24"
}
variable "public_az" {
    description = "public cidr"
    default = "ap-south-1a"
}
variable "public_cidr2" {
    description = "public cidr2"
    default = "192.168.25.0/24"
}
variable "public_az2" {
    description = "public cidr"
    default = "ap-south-1b"
}

variable "private_cidr" {
    description = "private cidr"
    default = "192.168.50.0/24"
}
variable "private_az" {
    description = "private az"
    default = "ap-south-1b"
  
}
variable "ami" {
    description = "ami_id"
    default = "ami-096b9cd38d837f984"
}
variable "instance_type" {
    default = "t2.micro"
    description = "instance type"
}