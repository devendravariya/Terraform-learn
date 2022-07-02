resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
  vpc_id      = "vpc-e88a5a83"   #default

  ingress = [ {
    cidr_blocks = [ "0.0.0.0/0" ]
    description = "test"
    from_port = 80
    protocol = "tcp"
    to_port = 80
  },
  {
    cidr_blocks = [ "0.0.0.0/0" ]
    description = "test"
    from_port = 22
    protocol = "tcp"
    to_port = 22
  }]
  egress = [ {
    cidr_blocks = [ "0.0.0.0/0" ]
    description = "test"
    from_port = 0
    protocol = "-1"
    self = false
    to_port = 0
  } ]
  tags = {
    Name = "rules"
  }
}