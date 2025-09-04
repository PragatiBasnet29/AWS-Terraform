resource "aws_vpc" "this" {
  cidr_block = var.cidr_block
  tags = {
    Name = var.vpc_name
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.this.id
  tags = {
    Name = "${var.vpc_name}-igw"
  }
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.this.id
  tags = {
    Name = "${var.vpc_name}-public-rt"
  }
}

resource "aws_route" "public_internet_route" {
  route_table_id         = aws_route_table.public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}
