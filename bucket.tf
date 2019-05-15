resource "aws_s3_bucket" "cset_binaries" {
  # This bucket is used to store large CSET binaries.
  # Note that in production terraform workspaces, the string '-production' is
  # appended to the bucket name.  In non-production workspaces,
  # '-<workspace_name>' is appended to the bucket name.
  bucket = "${local.cset_bucket_name}"

  acl = "public-read"

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  tags = "${merge(var.tags, map("Name", "CSET Binaries"))}"

  lifecycle {
    prevent_destroy = true
  }
}

resource "aws_s3_bucket_object" "index_html" {
  key                    = "index.html"
  bucket                 = "${aws_s3_bucket.cset_binaries.id}"
  source                 = "bucket_content/index.html"
  content_encoding       = "utf-8"
  content_type           = "text/html"
  acl                    = "public-read"
  server_side_encryption = "AES256"
}
