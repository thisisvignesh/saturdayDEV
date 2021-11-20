resource "aws_security_group" "global-sg-2021" {
  name        = var.sgname
  description = "Allow SSH HTTP HTTPS"
  vpc_id      = aws_vpc.prod_vpc.id

  ingress {
    description = "ssh"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.cidr
  }

  ingress {
    description = "http"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = var.cidr
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = var.cidr
  }

  tags = {
    Name = var.sgname
  }
}