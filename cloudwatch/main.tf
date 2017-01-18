resource "aws_cloudwatch_metric_alarm" "default" {
  alarm_name                = "${var.alarm_name}"
  comparison_operator       = "${var.comparison_operator}"
  evaluation_periods        = "${var.evaluation_periods}"
  metric_name               = "${var.metric_name}"
  namespace                 = "${var.namespace}"
  period                    = "${var.period}"
  statistic                 = "${var.statistic}"
  threshold                 = "${var.threshold}"
  alarm_description         = "${var.alarm_description}"
  insufficient_data_actions = ["${var.eagle_eye_sns_topic_arn}", "${var.team_sns_topic_arn}"]
  ok_actions                = ["${var.eagle_eye_sns_topic_arn}", "${var.team_sns_topic_arn}"]
  alarm_actions             = ["${var.eagle_eye_sns_topic_arn}", "${var.team_sns_topic_arn}"]
}
