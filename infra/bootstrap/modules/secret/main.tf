resource "aws_secretsmanager_secret" "rds-credentials" {
  name = "production/rds/credentials"
}

resource "aws_secretsmanager_secret_version" "rds-credentials" {
  secret_id = aws_secretsmanager_secret.rds-credentials.id
  secret_string = jsonencode({
    username            = "memos-user"
    password = 
  })
}