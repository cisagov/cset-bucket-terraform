# IAM policy document that that allows permissions on the CSET
# bucket.
data "aws_iam_policy_document" "cset_bucket_doc" {
  statement {
    effect = "Allow"

    actions = [
      "s3:ListBucket",
    ]

    resources = [
      "${aws_s3_bucket.cset_binaries.arn}",
    ]
  }

  statement {
    effect = "Allow"

    actions = [
      "s3:GetObject",
      "s3:PutObject",
    ]

    resources = [
      "${aws_s3_bucket.cset_binaries.arn}/*",
    ]
  }
}
