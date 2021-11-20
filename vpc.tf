resource "aws_vpc" "prod_vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "main"
  }
}

resource "aws_internet_gateway" "prod-igw" {
  vpc_id = aws_vpc.prod_vpc.id

  tags = {
    Name = "prod-igw"
  }
}

resource "aws_subnet" "prod1-subnet" {
  count                   = length(var.subnets_cidr)
  vpc_id                  = aws_vpc.prod_vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-west-2a"
  tags = {
    Name = "prod_subnet"
  }
}

# Route table: attach Internet Gateway
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.prod_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.prod-igw.id
  }
  tags = {
    Name = "prodRouteTable"
  }
}

# Route table association with public subnets
resource "aws_route_table_association" "prod-rt" {
  count          = length(var.subnets_cidr)
  subnet_id      = element(aws_subnet.prod1-subnet.*.id, count.index)
  route_table_id = aws_route_table.public_rt.id
}

