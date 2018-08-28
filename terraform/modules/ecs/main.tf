
resource "aws_ecr_repository" "ecr-repo" {
  name = "${var.ecr_repo_name}"
}

resource "aws_ecs_cluster" "ecs-cluster" {
  name = "${var.ecs_cluster_name}"
}


resource "aws_instance" "ecs-ec2" {
  instance_type = "${var.ec2_instance_type}"
  ami = "${var.ecs_ec2_ami}"
  subnet_id = "${aws_subnet.ecs-a.id}"
  count = "${var.ecs_ec2_count}"

  user_data = "${data.template_file.ecs-userdata.rendered}"

  tags {
    Name = "ecs-ec2-${count.index}"
  }
}

data "template_file" "ecs-userdata" {
  template = "${file("${path.module}/ecs-userdata.tpl")}"

  vars {
    cluster_name = "${var.ecs_cluster_name}"
  }
}


resource "aws_subnet" "ecs-a" {
  vpc_id = "${var.vpc_id}"
  cidr_block = "${var.ecs_a_cidr}"
  availability_zone = "${var.az_a}"
  tags {
    Name = "ecs-a"
  }
}

resource "aws_subnet" "ecs-b" {
  vpc_id = "${var.vpc_id}"
  cidr_block = "${var.ecs_b_cidr}"
  availability_zone = "${var.az_b}"
  tags {
    Name = "ecs-b"
  }
}
