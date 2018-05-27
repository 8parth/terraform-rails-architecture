output "vpc_id" {
  value = "${aws_vpc.vpc.id}"
}

output "public_subnet_id" {
  value = "${aws_subnet.public_subnet.id}"
}

output "private_subnet_id" {
  value = "${aws_subnet.private_subnet.id}"
}

output "public_subnet_id_2" {
  value = "${aws_subnet.public_subnet_2.id}"
}

output "default_sg_id" {
  value = "${aws_security_group.default.id}"
}

output "bastian_host.public_ip" {
  value = "${aws_instance.bastion.public_ip}"
}
