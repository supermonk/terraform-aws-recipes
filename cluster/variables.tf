variable "region" {
  description = "The AWS region to create resources in."
  default = "ap-southeast-2"
}

variable "ecs_cluster_name" {
  description = "The name of the Amazon ECS cluster."
}

variable "environment_tag" {
  description = "Role of the ec2 instance, defaults to <DEV>"
  default = "DEV"
}

variable "costcenter_tag" {
  description = "Role of the ec2 instance, defaults to <DEV>"
  default = "DEV"
}

variable "stream_tag" {
  description = "Team which owns this"
}

/* ECS optimized AMIs per region */
variable "ecs_amis" {
  default = {
    us-east-1	=	"ami-6bb2d67c"
    ap-southeast-1	=	"ami-55598036"
    ap-southeast-2	=	"ami-0e20176d"
  }
}

variable "ecs_instance_type" {
  default = "t2.micro"
  description = "size of the aws ec2 instance to use in the cluster"
}

variable "ssh_key" {
  description = "The aws ssh key name."
}

variable "vpc_id" {
  description = "the vpc in which the ec2 instances to be created"
}

variable "vpc_subnets" {
  description = "Vpc subnets where the ec2 instances should be launched"
}

variable "ecs_auto_scaling_min_size" {
  default = 1
  description = "minimum instances to run in the ecs cluster"
}
variable "ecs_auto_scaling_max_size" {
  description = "maximum instances to run in the ecs cluster"
}
variable "ecs_auto_scaling_desired_size" {
  description = "desired size of the cluster"
}

variable "vpc_cidr_blocks" {
  description = "the cidr blocks that can access the cluster"
}

variable "vpn_cidr_range" {
  description = "cidr block from which vpn connection will be established or you would like to access"
}
