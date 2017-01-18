resource "aws_cloudwatch_log_metric_filter" "default" {
  name           = "${var.log_metric_filter_name}"
  pattern        = "${var.log_metric_filter_pattern}"
  log_group_name = "${var.log_group_name}"

  metric_transformation {
    name      = "EventCount"
    namespace = "${var.metric_transformation_namespace}"
    value     = "1"
  }
}
