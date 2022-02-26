data "aws_availability_zones" "available" {}

resource "aws_vpc" "main" {
  cidr_block = var.main_vpc_cidr
  tags = {
    Name     = "${var.env}-vpc"
    UserName = "pol.iowa666@gmail.com"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name     = "${var.env}-igw"
    UserName = "pol.iowa666@gmail.com"
  }
}

resource "aws_subnet" "private_subnets" {
  count                   = length(var.private_subnets_cidrs)
  vpc_id                  = aws_vpc.main.id
  cidr_block              = element(var.private_subnets_cidrs, count.index)
  availability_zone       = data.aws_availability_zones.available.names[count.index]
  map_public_ip_on_launch = true
  tags = {
    Name     = "${var.env}-private-${count.index + 1}"
    UserName = "pol.iowa666@gmail.com"
  }

}

resource "aws_route_table" "private_subnets" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block     = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name     = "${var.env}-route-private-subnets"
    UserName = "pol.iowa666@gmail.com"
  }
}

resource "aws_route_table_association" "private_rt_association" {
  count          = length(aws_subnet.private_subnets[*].id)
  subnet_id      = element(aws_subnet.private_subnets[*].id, count.index)
  route_table_id = aws_route_table.private_subnets.id
}


resource "aws_eip" "nat" {
  count = length(var.private_subnets_cidrs)
  vpc   = true
  tags = {
    Name     = "${var.env}-nat-${count.index + 1}"
    UserName = "pol.iowa666@gmail.com"
  }
}

resource "aws_nat_gateway" "natgw" {
  count         = length(var.private_subnets_cidrs)
  allocation_id = aws_eip.nat[count.index].id
  subnet_id     = element(aws_subnet.private_subnets[*].id, count.index)
  tags = {
    Name     = "${var.env}-natgw-${count.index + 1}"
    UserName = "pol.iowa666@gmail.com"
  }
}
