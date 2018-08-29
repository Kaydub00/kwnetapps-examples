
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
  iam_instance_profile = "${aws_iam_instance_profile.ecs_instance.name}"

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
  map_public_ip_on_launch = true
  tags {
    Name = "ecs-a"
  }
}

resource "aws_subnet" "ecs-b" {
  vpc_id = "${var.vpc_id}"
  cidr_block = "${var.ecs_b_cidr}"
  availability_zone = "${var.az_b}"
  map_public_ip_on_launch = true
  tags {
    Name = "ecs-b"
  }
}

resource "aws_iam_instance_profile" "ecs_instance" {
  name = "ecs_instance"
  role = "${aws_iam_role.ecs.name}"
}

resource "aws_iam_role" "ecs" {
  name = "ecs"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action":"sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow"
    }
  ]
}
EOF
}

resource "aws_iam_policy" "ecs" {
  name = "ecs"
  description = "Policy for ECS nodes"

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "ecs:CreateCluster",
        "ecs:DeregisterContainerInstance",
        "ecs:DiscoverPollEndpoint",
        "ecs:Poll",
        "ecs:RegisterContainerInstance",
        "ecs:StartTelemetrySession",
        "ecs:Submit*",
        "ecr:GetAuthorizationToken",
        "ecr:BatchCheckLayerAvailability",
        "ecr:GetDownloadUrlForLayer",
        "ecr:BatchGetImage",
        "logs:CreateLogStream",
        "logs:PutLogEvents"
      ],
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "ecs" {
  role = "${aws_iam_role.ecs.name}"
  policy_arn = "${aws_iam_policy.ecs.arn}"
}
