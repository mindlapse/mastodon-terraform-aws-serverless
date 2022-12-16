
resource "aws_security_group" "sg" {

  name        = "${local.prefix_hyphen}-${var.simple_name}-sg"
  description = "Allow TLS inbound traffic"

  vpc_id = var.vpc_id

  dynamic "ingress" {
    for_each = var.container_port == null ? [] : [1]

    content {
      description      = "TLS from internet"
      from_port        = var.container_port
      to_port          = var.container_port
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    }
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}