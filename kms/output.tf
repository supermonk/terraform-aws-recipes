output "key arn" {
  value = "${aws_kms_key.default.arn}"
}
output "key alias arn" {
  value = "${aws_kms_alias.default.arn}"
}
