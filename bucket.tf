resource "aws_s3_bucket" "cset_binaries" {
  # This bucket is used to store large CSET binaries.
  # Note that in production terraform workspaces, the string '-production' is
  # appended to the bucket name.  In non-production workspaces,
  # '-<workspace_name>' is appended to the bucket name.
  bucket = "${local.production_workspace ? format("%s-production", var.cset_s3_bucket_name) : format("%s-%s", var.cset_s3_bucket_name, terraform.workspace)}"

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
