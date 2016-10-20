variable "region" {
  description = "The AWS region to create resources in."
}

variable "log_group_name" {  
}

variable "retention_in_days" {
	default = "90"
}