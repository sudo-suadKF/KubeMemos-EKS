resource "aws_db_subnet_group" "rds-private-subnets" {
  name       = "rds-private-subnets"
  subnet_ids = var.private-subs-id

  tags = {
    Name = "My DB subnet group"
  }
}
