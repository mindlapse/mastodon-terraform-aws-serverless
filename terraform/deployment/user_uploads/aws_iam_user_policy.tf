
resource "aws_iam_user_policy" "s3_rw" {

    name = "${local.prefix}_s3_rw"
    user = aws_iam_user.s3_uploads.name

    policy = data.aws_iam_policy_document.s3_rw.json
}
