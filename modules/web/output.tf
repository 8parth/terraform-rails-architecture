output "elb.hostname" {
  value = "${aws_alb.web.dns_name}"
}

output "web.private_ip" {
  value = "${aws_instance.web.*.private_ip}"
}
