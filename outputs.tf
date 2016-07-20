/*
 * network module outputs
 */

output "public_subnet_ids" {
  value = "${join(",", aws_subnet.public-subnet.*.id)}"
}

output "private_subnet_ids" {
  value = "${join(",", aws_subnet.private-subnet.*.id)}"
}

output "public_web_security_group_id" {
  value = "${aws_security_group.public-web-security-group.id}"
}

output "internal_security_group_id" {
  value = "${aws_security_group.internal-security-group.id}"
}

output "cisco_web_security_group_id" {
  value = "${aws_security_group.cisco-web-security-group.id}"
}

output "nat_ips" {
  value = "${join(",", aws_nat_gateway.nat-gw.*.public_ip)}"
}
