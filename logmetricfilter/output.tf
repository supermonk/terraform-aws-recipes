output "log_metric_filter_id" {
  value = "${aws_cloudwatch_log_metric_filter.default.id}"
}

output "log_metric_filter_name" {
  value = "${aws_cloudwatch_log_metric_filter.default.name}"
}

output "metric_transformation_namespace" {
  value = "${aws_cloudwatch_log_metric_filter.default.metric_transformation.namespace}"
}
