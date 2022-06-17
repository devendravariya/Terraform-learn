resource "aws_key_pair" "terraform" {
  key_name = "public_key"
  public_key = "${file("${var.key_path}")}"
}

