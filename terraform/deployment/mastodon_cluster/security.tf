
resource "aws_security_group" "puma_sg" {

  name        = "${local.prefix_hyphen}-puma-sg"
  description = "Allow TLS inbound traffic"

  vpc_id = var.vpc_id

  ingress {
    description      = "TLS from internet"
    from_port        = 3000
    to_port          = 3000
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }


  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}