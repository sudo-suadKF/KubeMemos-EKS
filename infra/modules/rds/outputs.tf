output "rds-secret-arn" {
  value = aws_db_instance.postgres-rds.master_user_secret[0].secret_arn
}

output "host-db" {
  value = aws_db_instance.postgres-rds.address
}