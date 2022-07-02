resource "aws_security_group" "sg" {
    name = "ec2sg"
    description ="mysg"
    vpc_id = data.aws_vpc.main
    ingress = [ {
      cidr_blocks = ["0.0.0.0/0"]
      description = "test"
      protocol  = "tcp"
      from_port = 80
      to_port = 80
    },
    {
      cidr_blocks = ["0.0.0.0/0"]
      description = "test"
      protocol  = "tcp"
      from_port = 22
      to_port = 22
    }
     ]
    egress = [ {
      cidr_blocks = ["0.0.0.0/0"]
      description = "test"
      protocol  = "-1"
      from_port = 0
      to_port = 0
    } ]
}