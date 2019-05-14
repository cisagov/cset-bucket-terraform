locals {
  # bucket origin id
  s3_origin_id = "S3-${aws_s3_bucket.cset_binaries.id}"
}

resource "aws_acm_certificate" "cset_cert" {
  domain_name       = "${var.distribution_domain}"
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_cloudfront_distribution" "cset_s3_distribution" {
  origin {
    domain_name = "${aws_s3_bucket.cset_binaries.bucket_regional_domain_name}"
    origin_id   = "${local.s3_origin_id}"
  }

  enabled             = true
  is_ipv6_enabled     = true
  comment             = "terraform cset site"
  default_root_object = "${var.root_object}"

  aliases = ["${var.distribution_domain}"]

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = "${local.s3_origin_id}"

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "allow-all"
    min_ttl                = 0
    default_ttl            = 30
    max_ttl                = 30
    compress               = true
    viewer_protocol_policy = "redirect-to-https"
  }

  price_class = "PriceClass_100"

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  custom_error_response {
    error_code            = 403
    error_caching_min_ttl = 30
    response_code         = 200
    response_page_path    = "/${var.root_object}"
  }

  custom_error_response {
    error_code            = 404
    error_caching_min_ttl = 30
    response_code         = 200
    response_page_path    = "/${var.root_object}"
  }

  viewer_certificate {
    acm_certificate_arn      = "${aws_acm_certificate.cset_cert.arn}"
    minimum_protocol_version = "TLSv1_2016"
    ssl_support_method       = "sni-only"
  }
}
