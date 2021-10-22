provider "aws" {
  region = var.region
}

resource "aws_vpc" "DogoAL" {
  cidr_block           = var.address_space
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    name        = "${var.prefix}-vpc-${var.region}"
    environment = "DogProduction"
  }
}

resource "aws_subnet" "DogoAL" {
  vpc_id     = aws_vpc.DogoAL.id
  cidr_block = var.subnet_prefix

  tags = {
    name = "${var.prefix}-subnet"
  }
}

resource "aws_security_group" "DogoAL" {
  name = "${var.prefix}-security-group"

  vpc_id = aws_vpc.DogoAL.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
    prefix_list_ids = []
  }

  tags = {
    Name = "${var.prefix}-security-group"
  }
}

resource "aws_internet_gateway" "DogoAL" {
  vpc_id = aws_vpc.DogoAL.id

  tags = {
    Name = "${var.prefix}-internet-gateway"
  }
}

resource "aws_route_table" "DogoAL" {
  vpc_id = aws_vpc.DogoAL.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.DogoAL.id
  }
}

resource "aws_route_table_association" "DogoAL" {
  subnet_id      = aws_subnet.DogoAL.id
  route_table_id = aws_route_table.DogoAL.id
}

resource "aws_eip" "DogoAL" {
  instance = aws_instance.DogoAL.id
  vpc      = true
}

resource "aws_eip_association" "DogoAL" {
  instance_id   = aws_instance.DogoAL.id
  allocation_id = aws_eip.DogoAL.id
}


resource "aws_instance" "DogoAL" {
  ami                         = var.AMI
  instance_type               = var.instance_type
  associate_public_ip_address = true
  subnet_id                   = aws_subnet.DogoAL.id
  vpc_security_group_ids      = [aws_security_group.DogoAL.id]

  tags = {
    Name = "${var.prefix}-DogoAL-instance"
  }
}
