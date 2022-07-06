 resource "aws_instance" "my-server" {
  ami           ="ami-0756a1c858554433e"
  instance_type = "t2.micro"
  key_name = "${aws_key_pair.key.key_name}"
  user_data = "${file("./install_apache.sh")}"
  provisioner "local-exec" {
    command = "echo ${self.private_ip} >> private_ips.txt"
  }
  provisioner "remote-exec" {
    inline = [
      "echo ${self.private_ip} >> /home/ubuntu/private_ips.txt"
    ]
    connection {
      type = "ssh"
      user = "ubuntu"
      host = "${self.public_ip}"
      private_key = "${file("/root/.ssh/terraform")}"
        }
  
  }
  tags = {
    Name = "web-server"
  }
}
#test

output "public_ip" {
  value = aws_instance.my-server.public_ip
  
}