provider "aws" {
  region = "us-west-1"
}

resource "aws_vpc" "Gabriel-vpc" {
  cidr_block = "172.101.0.0/16"

  tags = {
    Name = "Gabriel"
  }
}

resource "aws_subnet" "Gabriel-pub-rt-1" {
  vpc_id            = aws_vpc.Gabriel-vpc.id
  cidr_block        = "172.101.1.0/24"
  availability_zone = "us-west-1c"

  tags = {
    Name = "Gabriel-pub-rt-1"
  }
}

resource "aws_subnet" "Gabriel-pub-rt-2" {
  vpc_id            = aws_vpc.Gabriel-vpc.id
  cidr_block        = "172.101.2.0/24"
  availability_zone = "us-west-1b"

  tags = {
    Name = "Gabriel-pub-rt-2"
  }
}

resource "aws_subnet" "Gabriel-pub-rt-3" {
  vpc_id            = aws_vpc.Gabriel-vpc.id
  cidr_block        = "172.101.3.0/24"
  availability_zone = "us-west-1c"

  tags = {
    Name = "Gabriel-priv-rt-3"
  }
}

resource "aws_subnet" "Gabriel-pub-rt-4" {
  vpc_id            = aws_vpc.Gabriel-vpc.id
  cidr_block        = "172.101.4.0/24"
  availability_zone = "us-west-1b"

  tags = {
    Name = "Gabriel-priv-rt-4"
  }
}

resource "aws_internet_gateway" "Gabriel-igw"{
    vpc_id = aws_vpc.Gabriel-vpc.id

    tags = {
        Name = "Gabriel-igw"
    }
}

resource "aws_route_table" "Gabriel-pub-rt"{
    vpc_id = aws_vpc.Gabriel-vpc.id

     route{
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.Gabriel-igw.id
     }
     tags = {
        Name = "Gabriel-pub-rt"
    }
}

resource "aws_route_table_association" "Gabriel-route-a"{
    subnet_id = aws_subnet.Gabriel-pub-rt-1.id
    route_table_id = aws_route_table.Gabriel-pub-rt.id
}

resource "aws_route_table_association" "Gabriel-route-b"{
    subnet_id = aws_subnet.Gabriel-pub-rt-2.id
    route_table_id = aws_route_table.Gabriel-pub-rt.id
}