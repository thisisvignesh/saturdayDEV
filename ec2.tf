resource "aws_network_interface" "foo" {
  subnet_id   = aws_subnet.prod1-subnet.id
  private_ips = ["10.0.1.5"]

  tags = {
    Name = "primary_network_interface"
  }
}

resource "aws_instance" "foo" {
  ami           = "ami-0108d6a82a783b352"
  instance_type = "t2.micro"
  key_name      = "mumbaiacc2"

  tags = {
    Name = "web-1"
  }

  network_interface {
    network_interface_id = aws_network_interface.foo.id
    device_index         = 0
  }
}