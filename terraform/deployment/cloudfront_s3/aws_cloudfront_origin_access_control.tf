
resource "aws_cloudfront_origin_access_control" "oac" {
  # (Required) A name that identifies the Origin Access Control.
  name = "${local.prefix}_oac"

  # (Required) The description of the Origin Access Control. It may be empty.
  description = "${local.prefix}_oac"

  # (Required) The type of origin that this Origin Access Control is for. The only valid value is s3.
  origin_access_control_origin_type = "s3"

  # (Required) Specifies which requests CloudFront signs. Specify always for the most common use case. Allowed values: always, never, no-override.
  signing_behavior = "always"

  # (Required) Determines how CloudFront signs (authenticates) requests. Valid values: sigv4.
  signing_protocol = "sigv4"
}