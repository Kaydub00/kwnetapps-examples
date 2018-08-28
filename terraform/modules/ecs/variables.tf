
variable "ecr_repo_name" {}

variable "ecs_cluster_name" {}

variable "ecs_ec2_count" {
  default = 2
}

variable "ec2_instance_type" {
  default = "t2.small"
}

variable "ecs_ec2_ami" {
  default = "ami-00d4f478"
}

variable "vpc_id" {}

variable "ecs_a_cidr" {}
variable "ecs_b_cidr" {}

variable "az_a" {}
variable "az_b" {}
