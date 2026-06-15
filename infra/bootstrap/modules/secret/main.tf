resource "aws_secretsmanager_secret" "rds-credentials" {
  name = "production/rds/credentials"
}

resource "random_password" "rds-password" {
  length = 32
  special = false
}

resource "aws_secretsmanager_secret_version" "rds-credentials" {
  secret_id = aws_secretsmanager_secret.rds-credentials.id
  secret_string = jsonencode({
    username            = "memos-user"
    password            = random_password.rds-password.result
  })
}

resource "aws_secretsmanager_secret_rotation" "rds-credentials" {
  secret_id = aws_secretsmanager_secret.rds-credentials.id
  
  
  rotation_rules {
    automatically_after_days = 30
  }


}