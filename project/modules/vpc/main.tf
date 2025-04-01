resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr_block
  tags = {
    Unity = "${var.project_name}"
    Name = "${var.project_name}"
  }
}

resource "aws_eip" "eip_nat" {
  vpc = true
}

resource "aws_subnet" "priv_subnets" {
  for_each = var.priv_subnets
  vpc_id = aws_vpc.vpc.id
  cidr_block = cidrsubnet (var.vpc_cidr_block, 8, each.value.ipv4)
  availability_zone = "${var.project_region}${each.value.subnet_Unity}"
  tags = {
    Unity = "${var.project_name}-${each.value.subnet_Unity}"
    Name = "${var.project_name}-${each.value.subnet_name}"
  }
}

resource "aws_subnet" "pub_subnets" {
  for_each          = var.pub_subnets
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = cidrsubnet(var.vpc_cidr_block, 8, each.value.ipv4)
  availability_zone = "${var.project_region}${each.value.subnet_az}"
  tags = {
    Unity = "${var.project_name}-${each.value.subnet_Unity}"
    Name  = "${var.project_name}-${each.value.subnet_name}"
  }
}
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Unity = "${var.project_name}-vpc"
    Name  = "${var.project_name}-igw"
  }
}
resource "aws_route_table" "route_pub" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Unity = "${var.project_name}-vpc"
    Name  = "${var.project_name}-route_pub"
  }
}
resource "aws_route_table_association" "route_pub_a" {
  for_each       = var.pub_subnets
  subnet_id      = aws_subnet.pub_subnets[each.key].id
  route_table_id = aws_route_table.route_pub.id
}