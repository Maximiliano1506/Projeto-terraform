provider "aws" {
  region = "us-west-1"
}

resource "aws_vpc" "Gabriel-vpc" {
  cidr_block = "172.101.0.0/16"

  tags = {
    Name = "Gabriel-vpc"
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

resource "aws_internet_gateway" "Gabriel-igw" {
    vpc_id = aws_vpc.Gabriel-vpc.id

    tags = {
        Name = "Gabriel-igw"
    }
}

resource "aws_route_table" "Gabriel-pub-rt" {
    vpc_id = aws_vpc.Gabriel-vpc.id

     route{
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.Gabriel-igw.id
     }
     tags = {
        Name = "Gabriel-pub-rt"
    }
}

resource "aws_route_table_association" "Gabriel-route-a" {
    subnet_id = aws_subnet.Gabriel-pub-rt-1.id
    route_table_id = aws_route_table.Gabriel-pub-rt.id
}

resource "aws_route_table_association" "Gabriel-route-b" {
    subnet_id = aws_subnet.Gabriel-pub-rt-2.id
    route_table_id = aws_route_table.Gabriel-pub-rt.id
}

resource "aws_security_group" "Gabriel-sg-nginx" {
  name = "security_group"
  vpc_id = aws_vpc.Gabriel-vpc.id

  tags = {
    name = "Gabriel-sg-nginx"
  }
}

  resource "aws_vpc_security_group_ingress_rule" "Gabriel_ingress_80_sg_rule" {
  security_group_id = aws_security_group.Gabriel-sg-nginx.id
  from_port   = 80
  to_port     = 80
  ip_protocol    = "tcp"
  cidr_ipv4 = "0.0.0.0/0"
  }

  resource "aws_vpc_security_group_ingress_rule" "Gabriel_ingress_22_sg_rule" {
  security_group_id = aws_security_group.Gabriel-sg-nginx.id
  from_port   = 22
  to_port     = 22
  ip_protocol    = "tcp"
  cidr_ipv4 = "0.0.0.0/0"
  }

resource "aws_vpc_security_group_egress_rule" "Gabriel_egress_sg_rule" {
  security_group_id = aws_security_group.Gabriel-sg-nginx.id
  ip_protocol    = "-1"
  cidr_ipv4 = "0.0.0.0/0"
}

data "aws_ami" "amzn-linux-2023-ami"{
  most_recent = true
  owners = ["amazon"]

  filter {
    name = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }

  tags = {
    name = "linux-filter"
  }
}

resource "aws_network_interface" "Gabriel_nginx_ei"{
  subnet_id = aws_subnet.Gabriel-pub-rt-1.id

  tags ={
    name = "Gabriel-nginx-ei"
  }
}

resource "aws_instance" "Gabriel-nginx"{
  ami = data.aws_ami.amzn-linux-2023-ami.id
  instance_type = "t3.micro"
  subnet_id = aws_subnet.Gabriel-pub-rt-1.id
  vpc_security_group_ids = [aws_security_group.Gabriel-sg-nginx.id]

  associate_public_ip_address = true

  tags = {
    Name = "Gabriel-sg-nginx"
  }

}
