provider "aws" {
  region = "${var.region}"
}

resource "aws_ecr_repository" "default" {
  name = "${var.ecr_repo_name}"
}
