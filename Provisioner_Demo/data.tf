#data
data "aws_vpc" "main" {
  id = "vpc-e88a5a83"
}


data "template_file" "user-data" {
    template = file("./userdata.yaml")
  
}