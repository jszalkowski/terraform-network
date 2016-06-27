/*
 * network templates
 */

resource "template_file" instance-user-data {
  template = "${file("${path.module}/user_data/authorized_keys-setup.sh")}"
  vars {
    user = "ec2-user"
    authorized_keys = "${var.authorized_keys}"
  }
}
