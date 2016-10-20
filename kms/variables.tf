variable "region" {
  description = "The availability zones"
  default = "ap-southeast-2"
}

variable "key_description" {
  description = "description for the key"
}

variable "key_alias" {
  description = "kms key alias"
}
