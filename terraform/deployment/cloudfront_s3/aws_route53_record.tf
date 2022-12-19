resource "aws_route53_record" "files" {

  # (Required) The ID of the hosted zone to contain this record.
  zone_id = var.hosted_zone_id

  # The name of the record.
  name = var.cloudfront_domain

  # (Required) The record type. Valid values are A, AAAA, CAA, CNAME, DS, MX, NAPTR, NS, PTR, SOA, SPF, SRV and TXT.
  type = "A"

  # (Required for non-alias records) The TTL of the record.
  ttl = null

  # (Required for non-alias records) A string list of records. 
  # To specify a single record value longer than 255 characters such as a TXT record for DKIM, add 
  # \"\" inside the Terraform configuration string (e.g., "first255characters\"\"morecharacters").
  records = null

  # (Optional) Unique identifier to differentiate records with routing policies from one another.
  # Required if using failover, geolocation, latency, multivalue_answer, or weighted routing policies documented below.
  set_identifier = null

  # (Optional) The health check the record should be associated with.
  health_check_id = null

  # (Optional) An alias block. Conflicts with ttl & records. Documented below.
  alias {
    # (Required) DNS domain name for a CloudFront distribution, S3 bucket, ELB, or another resource record set in this hosted zone.
    name = aws_cloudfront_distribution.distro.domain_name

    # (Required) Hosted zone ID for a CloudFront distribution, S3 bucket, ELB, or Route 53 hosted zone. See resource_elb.zone_id for example.
    zone_id = aws_cloudfront_distribution.distro.hosted_zone_id

    # (Required) Set to true if you want Route 53 to determine whether to respond to DNS queries using this resource record set 
    # by checking the health of the resource record set. Some resources have special requirements, see related part of documentation.
    evaluate_target_health = false
  }

  # (Optional) A block indicating the routing behavior when associated health check fails. Conflicts with any other routing policy. Documented below.
  # failover_routing_policy {}

  # (Optional) A block indicating a routing policy based on the geolocation of the requestor. Conflicts with any other routing policy. Documented below.
  # geolocation_routing_policy {}

  # (Optional) A block indicating a routing policy based on the latency between the requestor and an AWS region. Conflicts with any other routing policy. Documented below.
  # latency_routing_policy {}

  # (Optional) A block indicating a weighted routing policy. Conflicts with any other routing policy. Documented below.
  # weighted_routing_policy {}

  # (Optional) Set to true to indicate a multivalue answer routing policy. Conflicts with any other routing policy.
  # multivalue_answer_routing_policy {}

  # (Optional) Allow creation of this record in Terraform to overwrite an existing record, if any.
  # This does not affect the ability to update the record in Terraform and does not prevent other resources within Terraform 
  # or manual Route 53 changes outside Terraform from overwriting this record. false by default. 
  # This configuration is not recommended for most environments.
  allow_overwrite = false
}


