/*
 * gateway configurations
 */

resource "aws_internet_gateway" "igw" {
  vpc_id = "${aws_vpc.vpc.id}"
  tags {
    Name = "${var.app_name}-${var.environment}-igw"
    Application = "${element(split(var.name_delim, var.app_name), 0)}"
    Environment = "${var.environment}"
  }
}

resource "aws_eip" "nat-eip" {
  count = "${var.az_count}"
  vpc = true
}

resource "aws_nat_gateway" "nat-gw" {
  count = "${var.az_count}"
  allocation_id = "${element(aws_eip.nat-eip.*.id, count.index)}"
  subnet_id = "${element(aws_subnet.public-subnet.*.id, count.index)}"
  depends_on = ["aws_internet_gateway.igw"]
}

resource "aws_route_table" "public-route-table" {
  count = "${var.az_count}"
  vpc_id = "${aws_vpc.vpc.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.igw.id}"
  }
  tags {
    Name = "${var.app_name}-${var.environment}-public-subnet-route-table-${count.index}"
    Application = "${element(split(var.name_delim, var.app_name), 0)}"
    Environment = "${var.environment}"
  }
}

resource "aws_route_table_association" "public-route-table-association" {
  count = "${var.az_count}"
  subnet_id = "${element(aws_subnet.public-subnet.*.id, count.index)}"
  route_table_id = "${element(aws_route_table.public-route-table.*.id, count.index)}"
}

resource "aws_route_table" "private-route-table" {
  count = "${var.az_count}"
  vpc_id = "${aws_vpc.vpc.id}"
  route {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = "${element(aws_nat_gateway.nat-gw.*.id, count.index)}"
  }
  tags {
    Name = "${var.app_name}-${var.environment}-private-subnet-route-table-${count.index}"
    Application = "${element(split(var.name_delim, var.app_name), 0)}"
    Environment = "${var.environment}"
  }
}

resource "aws_route_table_association" "private-route-table-association" {
  count = "${var.az_count}"
  subnet_id = "${element(aws_subnet.private-subnet.*.id, count.index)}"
  route_table_id = "${element(aws_route_table.private-route-table.*.id, count.index)}"
}
