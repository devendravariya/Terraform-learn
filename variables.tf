variable "aws_region" {
    default = "ap-south-1"
}
variable "vpc_cidr" {
    default = "192.168.0.0/16"
}
variable "subnets_cidr" {
    type = list 
    default = ["192.168.0.0/24", "192.168.50.0/24"]
}
variable "azs" {
    type = list
    default = ["ap-south-1a", "ap-south-1b"]
  
}