resource "aws_cloudfront_distribution" "distro" {

  provider = aws.us-east-1

  # (Optional) - Extra CNAMEs (alternate domain names), if any, for this distribution.
  aliases = [var.web_domain]

  # (Optional) - Any comments you want to include about the distribution.
  comment = "Mastodon cloudfront"

  # (Optional) - One or more custom error response elements (multiples allowed).
  # custom_error_response { }

  # (Required) - The default cache behavior for this distribution (maximum one).
  default_cache_behavior {

    # (Required) - Controls which HTTP methods CloudFront processes and forwards to your Amazon S3 bucket or your custom origin.
    allowed_methods = ["GET", "HEAD", "OPTIONS", "PUT", "POST", "PATCH", "DELETE"]

    # (Required) - Controls whether CloudFront caches the response to requests using the specified HTTP methods.
    cached_methods = ["GET", "HEAD", "OPTIONS"]

    # (Optional) - The unique identifier of the cache policy that is attached to the cache behavior.
    # cache_policy_id = aws_cloudfront_cache_policy.cache_policy.id

    # (Optional) - Whether you want CloudFront to automatically compress content for web requests that include Accept-Encoding: gzip in the request header (default: false).
    compress = true

    # (Optional) - The default amount of time (in seconds) that an object is in a CloudFront cache before CloudFront forwards another request in the absence of an Cache-Control max-age or Expires header.
    default_ttl = 0

    # (Optional) - Field level encryption configuration ID
    # field_level_encryption_id = null

    # (Optional) - The forwarded values configuration that specifies how CloudFront handles query strings, cookies and headers (maximum one).
    forwarded_values {

      # (Required) - The forwarded values cookies that specifies how CloudFront handles cookies (maximum one).
      cookies {

        # (Required) - Whether you want CloudFront to forward cookies to the origin that is associated with this cache behavior. 
        # You can specify all, none or whitelist. If whitelist, you must include the subsequent whitelisted_names
        forward = "all"

        # (Optional) - If you have specified 'whitelist' to forward, the whitelisted cookies that you want CloudFront to forward to your origin.
        # whitelisted_names = null

      }

      # (Optional) - Headers, if any, that you want CloudFront to vary upon for this cache behavior. Specify * to include all headers.
      headers = ["*"]

      # (Required) - Indicates whether you want CloudFront to forward query strings to the origin that is associated with this cache behavior.
      query_string = true

      # (Optional) - When specified, along with a value of true for query_string, all query strings are forwarded, 
      # however only the query string keys listed in this argument are cached. 
      # When omitted with a value of true for query_string, all query string keys are cached.
      query_string_cache_keys = []
    }

    # (Optional) - A config block that triggers a lambda function with specific actions (maximum 4).
    # lambda_function_association {}

    # (Optional) - A config block that triggers a cloudfront function with specific actions (maximum 2).
    # function_association {}

    # (Optional) - The maximum amount of time (in seconds) that an object is in a CloudFront cache before 
    # CloudFront forwards another request to your origin to determine whether the object has been updated. 
    # Only effective in the presence of Cache-Control max-age, Cache-Control s-maxage, and Expires headers.
    max_ttl = 0 # 1 day

    # (Optional) - The minimum amount of time that you want objects to stay in CloudFront caches before CloudFront queries your origin to see whether the object has been updated. Defaults to 0 seconds.
    min_ttl = 0

    # (Optional) - The unique identifier of the origin request policy that is attached to the behavior.
    # origin_request_policy_id = null

    # (Optional) - The ARN of the real-time log configuration that is attached to this cache behavior.
    realtime_log_config_arn = null

    # (Optional) - The identifier for a response headers policy.
    response_headers_policy_id = null

    # (Optional) - Indicates whether you want to distribute media files in Microsoft Smooth Streaming format using the origin that is associated with this cache behavior.
    smooth_streaming = null

    # (Required) - The value of ID for the origin that you want CloudFront to route requests to when a request matches the path pattern either for a cache behavior or for the default cache behavior.
    target_origin_id = local.alb_origin

    # (Optional) - A list of key group IDs that CloudFront can use to validate signed URLs or signed cookies. See the CloudFront User Guide for more information about this feature.
    # trusted_key_groups = 

    # (Optional) - List of AWS account IDs (or self) that you want to allow to create signed URLs for private content. See the CloudFront User Guide for more information about this feature.
    # trusted_signers = 

    # (Required) - Use this element to specify the protocol that users can use to access the files in the origin specified by TargetOriginId when a request matches the path pattern in PathPattern. One of allow-all, https-only, or redirect-to-https.
    viewer_protocol_policy = "https-only"
  }

  # (Optional) - The object that you want CloudFront to return (for example, index.html) when an end user requests the root URL.
  default_root_object = null

  # (Required) - Whether the distribution is enabled to accept end user requests for content.
  enabled = true

  # (Optional) - Whether the IPv6 is enabled for the distribution.
  is_ipv6_enabled = true

  # (Optional) - The maximum HTTP version to support on the distribution. Allowed values are http1.1, http2, http2and3 and http3. The default is http2.
  http_version = "http2"

  # (Optional) - The logging configuration that controls how logs are written to your distribution (maximum one).
  # logging_config {}

  # (Optional) - An ordered list of cache behaviors resource for this distribution. 
  # List from top to bottom in order of precedence. The topmost cache behavior will have precedence 0.
  dynamic "ordered_cache_behavior" {
    for_each = [
      "/sw.js",
      "/assets/*",
      "/avatars/*",
      "/emoji/*",
      "/headers/*",
      "/packs/*",
      "/shortcuts/*",
      "/sounds/*",
      "/system/*"
    ]

    content {
      path_pattern    = ordered_cache_behavior.value
      allowed_methods = ["GET", "HEAD", "OPTIONS"]
      cached_methods  = ["GET", "HEAD"]
      compress        = true
      default_ttl     = local.cache_seconds

      forwarded_values {
        cookies {
          forward = "none"
        }
        query_string = false
      }

      max_ttl                = local.cache_seconds
      min_ttl                = 0
      target_origin_id       = local.s3_origin
      viewer_protocol_policy = "https-only"
    }
  }


  # (Required) - One or more origins for this distribution (multiples allowed).
  origin {
    # (Optional) - The number of times that CloudFront attempts to connect to the origin. Must be between 1-3. Defaults to 3.
    connection_attempts = 3

    # (Optional) - The number of seconds that CloudFront waits when trying to establish a connection to the origin. Must be between 1-10. Defaults to 10.
    connection_timeout = 10

    # The CloudFront custom origin configuration information. If an S3 origin is required, use origin_access_control_id or s3_origin_config instead.
    # custom_origin_config {}

    # (Required) - The DNS domain name of either the S3 bucket, or web site of your custom origin.
    domain_name = data.aws_s3_bucket.bucket.bucket_regional_domain_name

    # (Optional) - One or more sub-resources with name and value parameters that specify header data that will be sent to the origin (multiples allowed).
    # custom_header {}

    # (Optional) - The unique identifier of a CloudFront origin access control for this origin.
    origin_access_control_id = aws_cloudfront_origin_access_control.oac.id

    # (Required) - A unique identifier for the origin.
    origin_id = local.s3_origin

    # (Optional) - An optional element that causes CloudFront to request your content from a directory in your Amazon S3 bucket or your custom origin.
    # origin_path 

    # The CloudFront Origin Shield configuration information. Using Origin Shield can help reduce the load on your origin. For more information, see Using Origin Shield in the Amazon CloudFront Developer Guide.
    # origin_shield {}

    # The CloudFront S3 origin configuration information. If a custom origin is required, use custom_origin_config instead.
    # s3_origin_config {
    #   # (Required) - The CloudFront origin access identity to associate with the origin.
    #   origin_access_identity = aws_cloudfront_origin_access_identity.oai.s3_canonical_user_id
    # }
  }

  origin {
    connection_attempts = 3
    connection_timeout  = 10
    domain_name         = var.alb_domain
    origin_id           = local.alb_origin
    custom_origin_config {

      # (Required) - The HTTP port the custom origin listens on.
      http_port = 80

      # (Required) - The HTTPS port the custom origin listens on.
      https_port = 443

      # (Required) - The origin protocol policy to apply to your origin. One of http-only, https-only, or match-viewer.
      origin_protocol_policy = "https-only"

      # (Required) - The SSL/TLS protocols that you want CloudFront to use when communicating with your origin over HTTPS. A list of one or more of SSLv3, TLSv1, TLSv1.1, and TLSv1.2.
      origin_ssl_protocols = ["TLSv1.2"]

      # (Optional) The Custom KeepAlive timeout, in seconds. By default, AWS enforces a limit of 60. But you can request an increase.
      # origin_keepalive_timeout =

      # (Optional) The Custom Read timeout, in seconds. By default, AWS enforces a limit of 60. But you can request an increase.
      # origin_read_timeout =
    }
  }

  # (Optional) - One or more origin_group for this distribution (multiples allowed).
  # origin_group {}

  # (Optional) - The price class for this distribution. One of PriceClass_All, PriceClass_200, PriceClass_100
  price_class = "PriceClass_100"

  # (Required) - The restriction configuration for this distribution (maximum one).
  restrictions {
    geo_restriction {
      restriction_type = "blacklist"
      locations        = var.cloudfront_denylist
    }
  }

  # (Optional) A map of tags to assign to the resource. If configured with a provider default_tags configuration block present, 
  # tags with matching keys will overwrite those defined at the provider-level.
  # tags = null

  # (Required) - The SSL configuration for this distribution (maximum one).
  viewer_certificate {

    # The ARN of the AWS Certificate Manager certificate that you wish to use with this distribution. Specify this, cloudfront_default_certificate, or iam_certificate_id. The ACM certificate must be in US-EAST-1.
    acm_certificate_arn = data.aws_acm_certificate.cloudfront_cert.arn

    # true if you want viewers to use HTTPS to request your objects and you're using the CloudFront domain name for your distribution. Specify this, acm_certificate_arn, or iam_certificate_id.
    # cloudfront_default_certificate 

    # The IAM certificate identifier of the custom viewer certificate for this distribution if you are using a custom domain. Specify this, acm_certificate_arn, or cloudfront_default_certificate.
    # iam_certificate_id

    # The minimum version of the SSL protocol that you want CloudFront to use for HTTPS connections.
    # Can only be set if cloudfront_default_certificate = false. See all possible values in this table under "Security policy." 
    # Some examples include: TLSv1.2_2019 and TLSv1.2_2021. Default: TLSv1. NOTE: If you are using a custom certificate (specified with acm_certificate_arn or iam_certificate_id), 
    # and have specified sni-only in ssl_support_method, TLSv1 or later must be specified. If you have specified vip in ssl_support_method, only SSLv3 or TLSv1 can be specified. 
    # If you have specified cloudfront_default_certificate, TLSv1 must be specified.
    minimum_protocol_version = "TLSv1.2_2021"

    # Specifies how you want CloudFront to serve HTTPS requests. One of 'vip' or 'sni-only'. 
    # Required if you specify acm_certificate_arn or iam_certificate_id. NOTE: vip causes CloudFront to use a dedicated IP address and may incur extra charges.
    ssl_support_method = "sni-only"
  }

  # (Optional) - A unique identifier that specifies the AWS WAF web ACL, if any, to associate with this distribution. 
  # To specify a web ACL created using the latest version of AWS WAF (WAFv2), use the ACL ARN, for example aws_wafv2_web_acl.example.arn. 
  # To specify a web ACL created using AWS WAF Classic, use the ACL ID, for example aws_waf_web_acl.example.id. 
  # The WAF Web ACL must exist in the WAF Global (CloudFront) region and the credentials configuring this argument must have waf:GetWebACL permissions assigned.
  # web_acl_id =

  # (Optional) - Disables the distribution instead of deleting it when destroying the resource through Terraform. If this is set, the distribution needs to be deleted manually afterwards. Default: false.
  retain_on_delete = true

  # (Optional) - If enabled, the resource will wait for the distribution status to change from InProgress to Deployed. Setting this tofalse will skip the process. Default: true.
  wait_for_deployment = true

}