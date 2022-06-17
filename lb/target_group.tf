resource "aws_lb_target_group" "lb-targate" {
    name  = "terraform-targate-group"
    port = 80
    protocol = "HTTP"
    vpc_id = aws_vpc.terraform_vpc.id
}
resource "aws_lb_target_group_attachment" "terraform" {
  target_group_arn = aws_lb_target_group.lb-targate.arn
  target_id = aws_lb.terraform-lb.id
  port = 80
}