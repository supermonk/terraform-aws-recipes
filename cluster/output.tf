output "ecs_cluster_name" {
  value = "${aws_ecs_cluster.default.name}"
}

output "ecs_iam_id" {
  value = "${aws_iam_instance_profile.ecs.id}"
}

output "ecs_iam_instance_profile_id" {
  value = "${aws_iam_instance_profile.ecs.id}"
}

output "ecs_role_name" {
  value = "${aws_iam_role.ecs_role.name}"
}
