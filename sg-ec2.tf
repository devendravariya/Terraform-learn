resource "aws_security_group" "my-webserver" {
  name        = "webserver"
  description = "Allow HTTP from Anywhere"
  vpc_id = aws_vpc.terra_vpc.id
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "my-webserver"
    Site = "my-web-site"
  }
}