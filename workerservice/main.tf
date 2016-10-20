
## TODO: use container definitions resource https://www.terraform.io/docs/providers/aws/d/ecs_container_definition.html
resource "template_file" "task_definition" {  
  template = "${file("${path.root}/../templates/task-definitions/workerservice.json.tpl")}"

  vars {
    region                = "${var.region}"
    environment           = "${var.environment}"
    kms_region            = "${var.kms_region}"
    datacenter            = "${var.datacenter}"
    log_group_name        = "${var.log_group_name}"
    log_stream_prefix     = "${var.log_stream_prefix}"
    service_name          = "${var.ecs_service_name}"
    ecr_image             = "${var.ecr_image}"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_ecs_task_definition" "default" {
  family = "${var.ecs_service_name}"
  container_definitions = "${template_file.task_definition.rendered}"
  volume {
    name = "${var.ecs_service_name}-home"
    host_path = "/ecs/${var.ecs_service_name}-home"
  }
}

resource "aws_ecs_service" "default" {
  name = "${var.ecs_service_name}"
  cluster = "${var.ecs_cluster_name}"
  task_definition = "${aws_ecs_task_definition.default.arn}"
  desired_count = "${var.ecs_service_desired_count}"  
}
