
module "vpc" {
  source = "./modules/vpc"

  cidr_block = "${var.vpc_cidr_block}"
  vpc_name = "${var.vpc_name}"

}

module "ecs" {
  source = "./modules/ecs"

  ecr_repo_name = "${var.ecr_repo_name}"
  ecs_cluster_name = "${var.ecs_cluster_name}"

  vpc_id = "${module.vpc.app_vpc_id}"
  az_a = "${var.az_a}"
  az_b = "${var.az_b}"
  ecs_a_cidr = "${var.ecs_a_cidr}"
  ecs_b_cidr = "${var.ecs_b_cidr}"
}
