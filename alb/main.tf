provider "aws" {
  region = "${var.region}"
}

resource "aws_alb" "default" {
  name            = "${var.cluster_name}-alb"
  internal        = "${var.alb_is_internal}"
  security_groups = ["${aws_security_group.default.id}"]
  subnets         = ["${split(",", var.elb_subnets)}"]

  tags {
    Stream = "${var.stream_tag}"
  }
}

resource "aws_alb_target_group" "default" {
  name     = "${var.cluster_name}-alb-tg"
  port     = "80"
  protocol = "HTTP"
  vpc_id   = "${var.vpc_id}"
}

resource "aws_alb_listener" "default_https" {
  load_balancer_arn = "${aws_alb.default.id}"
  port = "443"
  protocol = "HTTPS"
  ssl_policy = "ELBSecurityPolicy-2015-05"
  certificate_arn = "${var.elb_ssl_certificate_id}"

  default_action {
    type = "forward"
    target_group_arn = "${aws_alb_target_group.default.id}"
  }
}
