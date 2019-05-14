# Find the CYBER ZONE
data "aws_route53_zone" "cyber_zone" {
  name = "cyber.dhs.gov."
}

resource "aws_acm_certificate_validation" "cert" {
  certificate_arn = "${aws_acm_certificate.cset_cert.arn}"

  # validation_record_fqdns = ["${aws_route53_record.cert_validation.fqdn}"]
}

# This DNS record gives Amazon Certificate Manager permission to
# generate certificates for cset.cyber.dhs.gov
resource "aws_route53_record" "cert_validation" {
  zone_id = "${data.aws_route53_zone.cyber_zone.zone_id}"
  name    = "${aws_acm_certificate.cset_cert.domain_validation_options.0.resource_record_name}"
  type    = "${aws_acm_certificate.cset_cert.domain_validation_options.0.resource_record_type}"
  ttl     = 60
  records = ["${aws_acm_certificate.cset_cert.domain_validation_options.0.resource_record_value}"]
}

resource "aws_route53_record" "rules_ncats_A" {
  zone_id = "${data.aws_route53_zone.cyber_zone.zone_id}"
  name    = "cset.${data.aws_route53_zone.cyber_zone.name}"
  type    = "A"

  alias {
    name                   = "${aws_cloudfront_distribution.cset_s3_distribution.domain_name}"
    zone_id                = "${aws_cloudfront_distribution.cset_s3_distribution.hosted_zone_id}"
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "rules_ncats_AAAA" {
  zone_id = "${data.aws_route53_zone.cyber_zone.zone_id}"
  name    = "cset.${data.aws_route53_zone.cyber_zone.name}"
  type    = "AAAA"

  alias {
    name                   = "${aws_cloudfront_distribution.cset_s3_distribution.domain_name}"
    zone_id                = "${aws_cloudfront_distribution.cset_s3_distribution.hosted_zone_id}"
    evaluate_target_health = false
  }
}
