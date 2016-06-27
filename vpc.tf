/*
 * vpc configuration
 */

resource "aws_vpc" "vpc" {
  cidr_block = "${lookup(var.cidr_base, var.environment)}.0.0/16"
  enable_dns_hostnames = true
  tags {
    Name = "${var.app_name}-${var.environment}-vpc"
    Application = "${element(split(var.name_delim, var.app_name), 0)}"
    Environment = "${var.environment}"
  }
}
