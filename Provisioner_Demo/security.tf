resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow TLS inbound traffic"
  vpc_id      = "vpc-e88a5a83"   #default

  ingress = [ {
    cidr_blocks = [ "0.0.0.0/0" ]
    description = "test"
    from_port = 80
    ipv6_cidr_blocks = []
    prefix_list_ids = []
    protocol = "tcp"
    security_groups = []
    self = false
    to_port = 80
  },
  {
    cidr_blocks = [ "0.0.0.0/0" ]
    description = "test"
    from_port = 22
    ipv6_cidr_blocks = []
    prefix_list_ids = []
    protocol = "tcp"
    security_groups = []
    self = false
    to_port = 22
  }]
  egress = [ {
    cidr_blocks = [ "0.0.0.0/0" ]
    description = "test"
    from_port = 0
    ipv6_cidr_blocks = []
    prefix_list_ids = []
    protocol = "-1"
    security_groups = []
    self = false
    to_port = 0
  } ]
  tags = {
    Name = "rules"
  }
}