resource "aws_instance" "web-server" {
  ami           = var.ami
  instance_type = var.instance_type
  tags = {
    Name = "web-server-${local.name}"
  }

}
