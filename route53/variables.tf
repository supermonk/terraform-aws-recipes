variable "region" {
  description = "The AWS region to create resources in."
}

variable "service_name" {
	description = "service name. this will be prefix to the existing zone"
}

variable "elb_dns_name" {
	description = "dns of the service to which a route 53 record to be added"
}

variable "route53_zone_id" {
	description = "the zone to add to"
}

