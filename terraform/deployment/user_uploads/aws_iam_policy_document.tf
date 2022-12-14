
data "aws_iam_policy_document" "s3_rw" {

  statement {
    sid = "1"

    actions = [
      "s3:PutObject",
      "s3:PutObjectAcl",
      "s3:GetObject",
      "s3:GetObjectAcl"
    ]

    resources = [
      module.simple_bucket.bucket_arn,
      "${module.simple_bucket.bucket_arn}/*",
    ]

    effect = "Allow"
  }
}