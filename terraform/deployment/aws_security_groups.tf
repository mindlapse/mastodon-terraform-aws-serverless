
resource "aws_security_group" "mastodon_alb" {

  name        = "${local.prefix}_mastodon_alb"
  description = "Allow TLS inbound traffic"

  vpc_id = module.network.vpc_id

  ingress {
    description      = "TLS from internet"
    from_port        = 443
    to_port          = 443
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


resource "aws_security_group" "mastodon_ecs" {

  name        = "${local.prefix}_mastodon_ecs"
  description = "Allow HTTP and HTTPS connections from anywhere (the normal ports for websites and SSL)."

  vpc_id = module.network.vpc_id

  ingress {
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    security_groups = [aws_security_group.mastodon_alb.id]
  }

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.mastodon_alb.id]
  }

  egress {
    description      = "Allow all outbound traffic"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}
