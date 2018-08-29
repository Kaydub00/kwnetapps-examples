variable "region" {
  default = "us-west-2"
}

region "az_a" {
  default = "us-west-2a"
}

region "az_b" {
  default = "us-west-2b"
}


variable "vpc_cidr_block" {
  default = "172.31.0.0/16"
}

variable "ecs_a_cidr" {
  default = "172.31.10.0/24"
}

variable "ecs_b_cidr" {
  default = "172.31.11.0/24"
}

variable "vpc_name" {
  default = "kwnetapps-vpc"
}

variable "ecr_repo_name" {
  default = "kwnetapps-repo"
}

variable "ecs_cluster_name" {
  default = "kwnetapps-ecs-cluster"
}
