resource "aws_instance" "instance" {
  count                = length(aws_subnet.public_subnet.*.id)
  ami                  = var.ami_id
  instance_type        = var.instance_type
  subnet_id            = element(aws_subnet.public_subnet.*.id, count.index)
  security_groups      = [aws_security_group.sg.id, ]
  key_name             = "local-1"
  tags = {
    "Name"        = "Instance-${count.index}"
    "Environment" = "Test"
    "CreatedBy"   = "Terraform"
  }

  timeouts {
    create = "10m"
  }

}