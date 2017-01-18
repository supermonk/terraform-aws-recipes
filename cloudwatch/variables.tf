variable "alarm_name" {
  description = "The descriptive name for the alarm. This name must be unique within the user's AWS account"
}

variable "comparison_operator" {
  description = "The arithmetic operation to use when comparing the specified Statistic and Threshold. The specified Statistic value is used as the first operand. Either of the following is supported: GreaterThanOrEqualToThreshold, GreaterThanThreshold, LessThanThreshold, LessThanOrEqualToThreshold"
}

variable "evaluation_periods" {
  description = "The number of periods over which data is compared to the specified threshold"
}

variable "metric_name" {
  description = "The name for the alarm's associated metric."
}

variable "namespace" {
  description = "The namespace for the alarm's associated metric."
}

variable "period" {
  description = "The period in seconds over which the specified statistic is applied."
}

variable "statistic" {
  description = "The statistic to apply to the alarm's associated metric. Either of the following is supported: SampleCount, Average, Sum, Minimum, Maximum"
}

variable "threshold" {
  description = "The value against which the specified statistic is compared."
}

variable "alarm_description" {
  description = "The description for the alarm. It should contain data in {KEY:VALUE} pair, such as 'Sample alarm. {Datacentre:DC0}{Stream:WAHCOO}'"
}

variable "eagle_eye_sns_topic_arn" {
  description = "EagleEye dashboard SNS topic arn"
}

variable "team_sns_topic_arn" {}
