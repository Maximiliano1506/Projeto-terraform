data "aws_ami" "imagem_ec2" {
    most_recent = true
    owners = [ "amazon" ]
    filter {
      name = "name"
      values = [ "al2023-ami-2023.*-x86_64" ]
    }
}

resource "aws_security_group" "gabriel_front_sg" {
    vpc_id = var.vpc_id
    name = "agbriel_front_sg"
    tags = {
      Name = "gabriel-front_sg"
    }
}

resource "aws_instance" "gabriel_front_ec2" {
    ami = data.aws_ami.imagem_ec2.id
    instance_type = "t2.micro"
    subnet_id = var.priv_subnets_id[0]
    associate_public_ip_address = true
    tags = {
      Name = "gabriel_front_ec2"
    }
}