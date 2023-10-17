provider "aws" {
  region     = "us-east-1"
  access_key = var.access_key
  secret_key = var.secret_key
}

/*Networking*/
/*START*/

resource "aws_vpc" "main" {
  cidr_block = "172.16.0.0/16"

  tags = {
    Name = "AWS-EC2-Basic-Architecture"
  }
}

resource "aws_subnet" "public_subnets" {
  count             = length(var.public_subnet)
  vpc_id            = aws_vpc.main.id
  cidr_block        = element(var.public_subnet, count.index)
  availability_zone = element(var.azs, count.index)

  tags = {
    Name = "Public Sub AWS-EC2-Basic-Architecture "
  }
}

resource "aws_subnet" "private_subnets" {
  count             = length(var.private_subnet)
  vpc_id            = aws_vpc.main.id
  cidr_block        = element(var.private_subnet, count.index)
  availability_zone = element(var.azs, count.index)

  tags = {
    Name = "Private Sub AWS-EC2-Basic-Architecture"
  }
}


resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "AWS-EC2-Basic-Architecture"
  }
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  tags = {
    Name = "Route Table Public"
  }
}

resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.main.id
  count  = length(aws_nat_gateway.nat-gateway)
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = element(aws_nat_gateway.nat-gateway[*].id, count.index)
  }
  tags = {
    Name = "Route Table Private Sub NATGW"
  }
}

resource "aws_route_table_association" "pub_associate" {
  count          = length(var.public_subnet)
  subnet_id      = element(aws_subnet.public_subnets[*].id, count.index)
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "private_associate" {
  count          = length(var.private_subnet)
  subnet_id      = element(aws_subnet.private_subnets[*].id, count.index)
  route_table_id = aws_route_table.private_rt[count.index].id
}

resource "aws_eip" "elasticip" {
  count = length(var.private_subnet)

  tags = {
    Name = "AWS-EC2-Basic-Architecture ElasticIP"
  }
}

resource "aws_nat_gateway" "nat-gateway" {
  count         = length(var.private_subnet)
  allocation_id = element(aws_eip.elasticip[*].id, count.index)
  subnet_id     = element(aws_subnet.private_subnets[*].id, count.index)

  tags = {
    Name = "AWS-EC2-Basic-Architecture NATGW"
  }
}
/*END*/

