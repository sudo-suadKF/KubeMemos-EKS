resource "aws_vpc" "my-vpc" {
  cidr_block           = var.vpc-cidr-block
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = var.vpc-tags
  }
}

# Public Subnets
resource "aws_subnet" "public_subnets" {
  for_each = local.public_subnets

  vpc_id                  = aws_vpc.my-vpc.id
  map_public_ip_on_launch = false

  vpc_id                  = aws_vpc.my-vpc.id
  map_public_ip_on_launch = false

  for_each = local.public_subnets

  cidr_block        = each.value.cidr_block
  availability_zone = each.value.availability_zone
  tags              = each.value.tags
}

# Private Subnets
resource "aws_subnet" "private_subnets" {
  for_each = local.private_subnets

  vpc_id                  = aws_vpc.my-vpc.id
  map_public_ip_on_launch = false

  vpc_id                  = aws_vpc.my-vpc.id
  map_public_ip_on_launch = false

  for_each = local.private_subnets

  cidr_block        = each.value.cidr_block
  availability_zone = each.value.availability_zone
  tags              = each.value.tags
}

# IGW
resource "aws_internet_gateway" "my-igw" {
  vpc_id = aws_vpc.my-vpc.id

  tags = {
    Name = var.igw-tags
  }
}

# NAT GW
resource "aws_nat_gateway" "my-nat-gw" {
  vpc_id            = aws_vpc.my-vpc.id
  availability_mode = var.nat-gw-mode
  connectivity_type = var.nat-gw-connectivity

  tags = {
    Name = var.nat-gw-tags
  }

  depends_on = [aws_internet_gateway.my-igw]
}

# Public RT
resource "aws_route_table" "public-rt" {
  vpc_id = aws_vpc.my-vpc.id

  route {
    cidr_block = var.internet-cidr
    gateway_id = aws_internet_gateway.my-igw.id
  }

  tags = {
    Name = var.public-rt-tags
  }
}

# Associate to public subnets
resource "aws_route_table_association" "public-rt-to-public-subnets" {
  for_each = aws_subnet.public_subnets

  subnet_id      = each.value.id
  route_table_id = aws_route_table.public-rt.id
}

# Private RT
resource "aws_route_table" "private-rt" {
  vpc_id = aws_vpc.my-vpc.id

  route {
    cidr_block     = var.internet-cidr
    nat_gateway_id = aws_nat_gateway.my-nat-gw.id
  }

  tags = {
    Name = var.private-rt-tags
  }
}

# Associate to private subnets
resource "aws_route_table_association" "private-rt-to-private-subnets" {
  for_each = aws_subnet.private_subnets

  subnet_id      = each.value.id
  route_table_id = aws_route_table.private-rt.id
}
