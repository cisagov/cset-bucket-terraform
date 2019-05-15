variable "aws_region" {
  description = "The AWS region to deploy into (e.g. us-east-1)."
  default     = "us-east-1"
}

variable "aws_availability_zone" {
  description = "The AWS availability zone to deploy into (e.g. a, b, c, etc.)."
  default     = "a"
}

variable "tags" {
  type        = "map"
  description = "Tags to apply to all AWS resources created"
  default     = {}
}

variable "cset_s3_bucket_name" {
  type        = "string"
  description = "The name of the bucket where the CSET files will be stored.  Note that in production terraform workspaces, the string '-production' will be appended to the bucket name.  In non-production workspaces, '-<workspace_name>' will be appended to the bucket name."
  default     = "ncats-cset-binaries"
}

variable "distribution_root_domain" {
  description = "The parent domain name of the cloudfront distribution and certificate."
  default     = "cyber.dhs.gov"
}

variable "distribution_sub_domain" {
  description = "The sub domain name of the cloudfront distribution and certificate."
  default     = "cset"
}

variable "root_object" {
  description = "The root object to serve when no path is provided, or an error occurs"
  default     = "index.html"
}
