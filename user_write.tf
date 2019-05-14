resource "aws_iam_user" "cset_write" {
  # We name the user based on the bucket name (which is based on the
  # terraform workspace name) to avoid name conflicts when deploying to
  # different workspaces
  name = "${format("%s-write", aws_s3_bucket.cset_binaries.id)}"

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_iam_access_key" "cset_write" {
  user = "${aws_iam_user.cset_write.name}"
}

# IAM policy document that that allows write permissions on the export
# bucket.  This will be applied to the cset_write role.
data "aws_iam_policy_document" "cset_write_doc" {
  statement {
    effect = "Allow"

    actions = [
      "s3:PutObject",
    ]

    resources = [
      "${aws_s3_bucket.cset_binaries.arn}/*",
    ]
  }
}

# The S3 policy for our role
resource "aws_iam_user_policy" "cset_write_policy" {
  user   = "${aws_iam_user.cset_write.name}"
  policy = "${data.aws_iam_policy_document.cset_write_doc.json}"
}
