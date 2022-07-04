module "test" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "user-service"
  description = "Security group for user-service with custom ports open within VPC, and PostgreSQL publicly open"
  vpc_id      = "vpc-e88a5a83"

  ingress_cidr_blocks      = ["172.31.0.0/16"]
  ingress_rules            = ["https-443-tcp"]
  ingress_with_cidr_blocks = [
    {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      description = "User-service ports"
      cidr_blocks = "0.0.0.0/0"
    },
    {
      rule        = "ssh-tcp"
      cidr_blocks = "172.31.0.0/16"
    },
  ]
}
