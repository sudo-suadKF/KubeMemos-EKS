data "aws_caller_identity" "current" {}

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
  kms_key_id = aws_kms_key.secrets-encrypt.key_id
}

resource "aws_secretsmanager_secret_version" "rds-credentials" {
  secret_id = aws_secretsmanager_secret.rds-credentials.id
  secret_string = jsonencode({
    username            = "memos-user"
    password = random_password.rds-password.result
  })

  lifecycle {
    ignore_changes = [secret_string]
  }
}

resource "aws_kms_key" "secrets-encrypt" {
  description             = "KMS key for Secrets Manager"
  deletion_window_in_days = 7
  enable_key_rotation     = true

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "EnableRootAccess"
        Effect = "Allow"
        Principal = {
          AWS = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
        }
        Action   = "kms:*"
        Resource = "*"
      }
    ]
  })
}

resource "aws_kms_alias" "secrets-alias" {
  name          = "alias/secrets-manager"
  target_key_id = aws_kms_key.secrets-encrypt.key_id
}