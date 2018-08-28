
output "app_vpc_id" {
  value = "${aws_vpc.main.id}"
}

output "app_cidr_block" {
  value = "${aws_vpc.main.cidr_block}"
}
