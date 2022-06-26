resource "aws_instance" "webserver" {
    count = 2
    ami = var.ami
    instance_type = var.instance_type
    availability_zone = "${element(var.azs, count.index)}"
  
}