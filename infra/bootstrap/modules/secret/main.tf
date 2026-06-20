resource "aws_secretsmanager_secret" "rds-credentials" {
  name = "production/rds/credentials"
}

resource "aws_secretsmanager_secret_version" "rds-credentials" {
  secret_id = aws_secretsmanager_secret.rds-credentials.id
  secret_string = jsonencode({
    username            = "memos-user"
  })
}

resource "aws_secretsmanager_secret_rotation" "rds-credentials" {
  secret_id = aws_secretsmanager_secret.rds-credentials.id
  rotation_lambda_arn = 
  
  rotation_rules {
    automatically_after_days = 30
  }
}