provider "aws" {
  region = "${var.region}"
}

resource "aws_kms_key" "default" {
    description = "${var.key_description}"
    enable_key_rotation = true
}

resource "aws_kms_alias" "default" {
    name = "alias/${var.key_alias}"
    target_key_id = "${aws_kms_key.default.key_id}"
}
