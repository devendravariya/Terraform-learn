resource "aws_lb" "terraform-lb" {
    name = "terraform-lb"
    internal = false
    load_balancer_type = "application"
    security_groups = [ "aws_security_group.terraform_sg.id"]
    subnets = ["aws_subnet.public_subnet.id" ]
    access_logs {
      bucket = "bucket_id"
      prefix = "test-lb"
      enabled  = true
    }
    tags = {
      "Name" = "terraform-lb"
    }
  
}