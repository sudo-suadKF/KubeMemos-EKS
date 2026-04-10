resource "aws_db_subnet_group" "rds-private-subnets" {
  name        = "rds-private-subnets"
  description = "Subnet group for rds"
  subnet_ids  = var.private-subs-id

  tags = {
    Name = "rds-private-subnets"
  }
}
