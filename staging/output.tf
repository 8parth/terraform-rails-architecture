output "elb_hostname" {
  value = "${module.web.elb.hostname}"
}

output "bastian_host_public_ip" {
  value = "${module.networking.bastian_host.public_ip}"
}
