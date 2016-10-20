provider "aws" {
  region = "${var.region}"
}

/**
 * Provides internal access to container ports
 */
resource "aws_security_group" "ecs" {
  name = "${var.ecs_cluster_name}-ecs-sg"
  description = "Container Instance Allowed Ports"
  vpc_id = "${var.vpc_id}"

  ingress {
    from_port = 1
    to_port   = 65535
    protocol  = "tcp"
    cidr_blocks = ["${split(",", var.vpc_cidr_blocks)}"]
  }

  ingress {
    from_port = 0
    to_port   = 0
    protocol  = "icmp"
    cidr_blocks = ["${var.vpn_cidr_range}"]
  }

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    cidr_blocks = ["${var.vpn_cidr_range}"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "ecs-sg"
    stream = "${var.stream_tag}"
  }
}

resource "template_file" "user_data" {
  template = "${file("${path.root}/../templates/user-data.tpl")}"

  vars {
    cluster_name = "${var.ecs_cluster_name}"
  }

  lifecycle {
    create_before_destroy = true
  }
}

/**
 * Launch configuration used by autoscaling group
 */
resource "aws_launch_configuration" "ecs" {
  image_id             = "${lookup(var.ecs_amis, var.region)}"
  instance_type        = "${var.ecs_instance_type}"
  key_name             = "${var.ssh_key}"
  security_groups      = ["${aws_security_group.ecs.id}"]
  iam_instance_profile = "${aws_iam_instance_profile.ecs.id}"
  user_data            = "${template_file.user_data.rendered}"

  lifecycle {
    create_before_destroy = true
  }
}

/**
 * Autoscaling group.
 */
resource "aws_autoscaling_group" "ecs" {
  launch_configuration = "${aws_launch_configuration.ecs.name}"
  min_size             = "${var.ecs_auto_scaling_min_size}"
  max_size             = "${var.ecs_auto_scaling_max_size}"
  desired_capacity     = "${var.ecs_auto_scaling_desired_size}"
  vpc_zone_identifier  = ["${split(",", var.vpc_subnets)}"]

  tag {
    key = "Name"
    value = "${var.ecs_cluster_name}-ecs-instance"
    propagate_at_launch = true
  }
  tag {
    key = "Stream"
    value = "${var.stream_tag}"
    propagate_at_launch = true
  }
  tag {
    key = "ServerRole"
    value = "ECS"
    propagate_at_launch = true
  }
  tag {
    key = "Cost Center"
    value = "${var.costcenter_tag}"
    propagate_at_launch = true
  }
  tag {
    key = "Environment"
    value = "${var.environment_tag}"
    propagate_at_launch = true
  }

  lifecycle {
    create_before_destroy = true
  }
}

/* ecs service cluster */
resource "aws_ecs_cluster" "default" {
  name = "${var.ecs_cluster_name}"
}
