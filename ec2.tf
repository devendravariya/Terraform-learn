resource "aws_instance" "local-server" {
    ami = var.ami
    instance_type = var.instance_type
    key_name = "${aws_key_pair.terraform.id}"
    vpc_security_group_ids = ["${aws_security_group.terraform-sg.id}"]
    subnet_id = "${aws_subnet.public_subnet.id}"
    source_dest_check = false
    user_data = "${file("install.sh")}"
    tags = {
      "Name" = "Local-server"
    }
}

