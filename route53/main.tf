provider "aws" {
  region = "${var.region}"
}
resource "aws_route53_record" "default" {
  zone_id = "${var.route53_zone_id}"
  name = "${var.service_name}"
  type = "CNAME"
  ttl = "300"
  records = ["${var.elb_dns_name}"]
}
