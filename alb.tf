resource "aws_alb" "alb" {
  name            = "terraform-example-alb"
  security_groups = aws_security_group.alb.id
  subnets         = ["${aws_subnet.public.*.id}"]
  tags {
    Name = "terraform-example-alb"
  }
}
resource "aws_alb_listener" "listener_http" {
  load_balancer_arn = "${aws_alb.alb.arn}"
  port              = "80"
  protocol          = "HTTP"

  default_action {
    target_group_arn = "${aws_alb_target_group.group.arn}"
    type             = "forward"
  }
}