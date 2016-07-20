/*
 * security group configuration
 */

resource "aws_security_group" "public-web-security-group" {
  name_prefix = "${var.app_name}-${var.environment}-public-web-"
  description = "allows http/https access for public instances"
  vpc_id = "${aws_vpc.vpc.id}"
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port = 80
    to_port = 80
    protocol = "tcp"
  }
  ingress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port = 443
    to_port = 443
    protocol = "tcp"
  }
  "egress" {
    cidr_blocks = ["0.0.0.0/0"]
    from_port = 0
    to_port = 0
    protocol = "-1"
  }
}

resource "aws_security_group" "internal-security-group" {
  name_prefix = "${var.app_name}-${var.environment}-internal-"
  description = "allow access from within VPC"
  vpc_id = "${aws_vpc.vpc.id}"
  ingress {
    cidr_blocks = ["${lookup(var.cidr_base, var.environment)}.0.0/16"]
    from_port = 0
    to_port = 0
    protocol = "-1"
  }
  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port = 0
    to_port = 0
    protocol = "-1"
  }
}

resource "aws_security_group" "bastion-security-group" {
  name_prefix = "${var.app_name}-${var.environment}-bastion-"
  description = "allow ssh access from Cisco"
  vpc_id = "${aws_vpc.vpc.id}"
  ingress {
    cidr_blocks = ["${split(",", var.cisco_cidr)}"]
    from_port = 22
    to_port = 22
    protocol = "tcp"
  }
  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port = 0
    to_port = 0
    protocol = "-1"
  }
}

resource "aws_security_group" "cisco-web-security-group" {
  name_prefix = "${var.app_name}-${var.environment}-cisco-web-"
  description = "allows http/https access from Cisco only"
  vpc_id = "${aws_vpc.vpc.id}"
  ingress {
    cidr_blocks = ["${split(",", var.cisco_cidr)}"]
    from_port = 80
    to_port = 80
    protocol = "tcp"
  }
  ingress {
    cidr_blocks = ["${split(",", var.cisco_cidr)}"]
    from_port = 443
    to_port = 443
    protocol = "tcp"
  }
  "egress" {
    cidr_blocks = ["0.0.0.0/0"]
    from_port = 0
    to_port = 0
    protocol = "-1"
  }
}
