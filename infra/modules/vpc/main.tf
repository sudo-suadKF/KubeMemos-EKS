resource "aws_vpc" "my-vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "my-vpc"
  }
}

# Public Subnets
resource "aws_subnet" "public_subnets" {
  vpc_id                  = aws_vpc.my-vpc.id
  map_public_ip_on_launch = false

  for_each = local.public_subnets

  cidr_block        = each.value.cidr_block
  availability_zone = each.value.availability_zone
  tags              = each.value.tags
}

# Private Subnets
resource "aws_subnet" "private_subnets" {
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
    Name = "my-igw"
  }
}

# NAT GW
resource "aws_nat_gateway" "my-nat-gw" {
  vpc_id            = aws_vpc.my-vpc.id
  availability_mode = "regional"
  connectivity_type = "public"

  tags = {
    Name = "my-nat-gw"
  }

  depends_on = [aws_internet_gateway.my-igw]
}
