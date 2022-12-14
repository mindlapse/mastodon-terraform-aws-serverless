resource "aws_ecr_repository" "mastodon" {
  name                 = "mastodon_configured"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = false
  }
}