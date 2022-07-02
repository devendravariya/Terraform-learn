 resource "aws_instance" "my-server" {
  ami           ="ami-0756a1c858554433e"
  instance_type = "t2.micro"
  key_name = "${aws_key_pair.key.key_name}"
  vpc_security_group_ids = ["aws_security_group.sg.id"]
  user_data = data.template_file.userdata.rendered
  tags = {
    Name = "web-server"
  }
}
