variable "region" {
  description = "The AWS region to create resources in."
}

variable "vpc_id" {
  description = "The VPC"
}

variable "cluster_name" {
  description = "Vpc subnets where the load balance for web service should be launched"  
}

variable "alb_is_internal" {
  default = "false"
  description = "internal or external elb for the web role, default is false."
}

variable "elb_subnets" {
  description = "Vpc subnets where the load balance for web service should be launched"  
}

variable "elb_ssl_certificate_id" {
}

variable "stream_tag" {
}