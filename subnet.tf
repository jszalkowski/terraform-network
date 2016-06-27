/*
 * subnet configurations
 */

resource "aws_subnet" "public-subnet" {
  count = "${var.az_count}"
  vpc_id = "${aws_vpc.vpc.id}"
  availability_zone = "${lookup(var.az_list, count.index+lookup(var.az_list_region_offset, var.region)+lookup(var.az_list_environment_offset, var.environment))}"
  cidr_block = "${lookup(var.cidr_base, var.environment)}.${lookup(var.cidr_public, count.index)}/24"
  map_public_ip_on_launch = true
  tags {
    Name = "${var.app_name}-${var.environment}-public-subnet-${count.index}"
    Application = "${element(split(var.name_delim, var.app_name), 0)}"
    Environment = "${var.environment}"
  }
}

resource "aws_subnet" "private-subnet" {
  count = "${var.az_count}"
  vpc_id = "${aws_vpc.vpc.id}"
  availability_zone = "${lookup(var.az_list, count.index+lookup(var.az_list_region_offset, var.region)+lookup(var.az_list_environment_offset, var.environment))}"
  cidr_block = "${lookup(var.cidr_base, var.environment)}.${lookup(var.cidr_private, count.index)}/${lookup(var.cidr_private_bits, var.environment)}"
  tags {
    Name = "${var.app_name}-${var.environment}-private-subnet-${count.index}"
    Application = "${element(split(var.name_delim, var.app_name), 0)}"
    Environment = "${var.environment}"
  }
}
