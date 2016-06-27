/*
 * bastion/jump configuration
 */

resource "aws_instance" "bastion" {
  count = "${var.az_count}"
  ami = "${lookup(var.bastion_image, var.region)}"
  instance_type = "${var.bastion_instance_type}"
  vpc_security_group_ids = ["${aws_security_group.bastion-security-group.id}"]
  subnet_id = "${element(aws_subnet.public-subnet.*.id, count.index)}"
  user_data = "${template_file.instance-user-data.rendered}"
  associate_public_ip_address = true
  tags {
    Name = "${var.app_name}-${var.environment}-bastion-${count.index}"
    Application = "${element(split(var.name_delim, var.app_name), 0)}"
    Environment = "${var.environment}"
  }
}

resource "aws_instance" "jump" {
  count = "${var.az_count}"
  ami = "${lookup(var.jump_image, var.region)}"
  instance_type = "${var.jump_instance_type}"
  vpc_security_group_ids = ["${aws_security_group.internal-security-group.id}"]
  subnet_id = "${element(aws_subnet.private-subnet.*.id, count.index)}"
  user_data = "${template_file.instance-user-data.rendered}"
  tags {
    Name = "${var.app_name}-${var.environment}-jump-${count.index}"
    Application = "${element(split(var.name_delim, var.app_name), 0)}"
    Environment = "${var.environment}"
  }
}
