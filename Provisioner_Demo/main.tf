 resource "aws_instance" "my-server" {
  ami           ="ami-0756a1c858554433e"
  instance_type = "t2.micro"
  key_name = "${aws_key_pair.key.key_name}"
  vpc_security_group_ids = module.test.test_id
  user_data = "${file("./install_apache.sh")}"
  tags = {
    Name = "web-server"
  }
}
