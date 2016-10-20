resource "aws_security_group" "default" {
  name = "${var.cluster_name}-alb-sg"
  description = "security group for alb"
  vpc_id = "${var.vpc_id}"

  # fix this to point only from the current vpc
  ingress {
    from_port = 1
    to_port   = 65535
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    name = "alb-sg"
    stream = "${var.stream_tag}"
  }
}