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
