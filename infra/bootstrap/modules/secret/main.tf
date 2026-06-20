resource "random_password" "rds-password" {
  length           = 32
  special          = true
  override_special = "!#$%^&*()-_=+[]{}|:,.<>?"
  # Avoid characters that cause issues in connection strings
  min_lower   = 4
  min_upper   = 4
  min_numeric = 4
  min_special = 2
}

resource "aws_secretsmanager_secret" "rds-credentials" {
  name = "production/rds/credentials"
}

resource "aws_secretsmanager_secret_version" "rds-credentials" {
  secret_id = aws_secretsmanager_secret.rds-credentials.id
  secret_string = jsonencode({
    username            = "memos-user"
    password = random_password.rds-password.result
  })
}