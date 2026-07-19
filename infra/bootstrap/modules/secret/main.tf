data "aws_caller_identity" "current" {}

resource "aws_secretsmanager_secret" "rds-credentials" {
  name       = var.secret-name
  kms_key_id = aws_kms_key.secrets-encrypt.key_id
}

resource "aws_kms_key" "secrets-encrypt" {
  description             = var.secret-kms-description
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
  name          = var.secret-alias
  target_key_id = aws_kms_key.secrets-encrypt.key_id
}