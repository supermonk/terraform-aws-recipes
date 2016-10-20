output "ecs_service_name" {
	value = "${aws_ecs_service.default.name}"
}

output "alb_target_group_id" {
	value = "${aws_alb_target_group.default.id}"
}