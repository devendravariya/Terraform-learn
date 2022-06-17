variable "region" {
    description = "region for setup"
    default = "ap-south-1"
}
variable "ami" {
    description = "ami id "
    default = "ami-068257025f72f470d" 
}
variable "instance_type" {
    description = "instance type"
    default = "t2.micro"
}
variable "vpc_cidr" {
    description = "cidr for vpc"
    default = "192.168.0.0/16"
}
variable "public_cidr" {
    description = "cidr for public subnet"
    default = "192.168.0.0/24"
}
variable "private_cidr" {
    description = "cidr for private subnet"
    default = "192.168.12.0/24"
}
variable "key_path" {
  description = "SSH Public Key path"
  default = "~/.ssh/id_rsa.pub"
}