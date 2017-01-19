output "alb_id" {
	value = "${aws_alb.default.id}"
}

output "alb_listener_id" {
	value = "${aws_alb_listener.default_https.id}"
}

output "alb_dns_name" {
	value = "${aws_alb.default.dns_name}"
}

output "alb_target_group_arn" {
	value = "${aws_alb_target_group.default.arn}"
}

