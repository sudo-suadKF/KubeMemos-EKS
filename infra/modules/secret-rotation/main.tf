data "aws_secretsmanager_secret" "rds-credentials" {
  name = "production/rds/credentials"
}

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

resource "aws_secretsmanager_secret_version" "rds-credentials" {
  secret_id = data.aws_secretsmanager_secret.rds-credentials.id
  secret_string = jsonencode({
    engine = "postgres"
    host = var.host-db
    username            = "memos-user"
    password = random_password.rds-password.result
    dbname = "memosdb"
    port = 5432
  })

  lifecycle {
    ignore_changes = [secret_string]
  }
}

resource "aws_secretsmanager_secret_rotation" "rds-credentials" {
  secret_id = data.aws_secretsmanager_secret.rds-credentials.id
  rotation_lambda_arn = ""
  
  rotation_rules {
    automatically_after_days = 30
  }
}

data "archive_file" "lambda" {
  type = "zip"
  source_file = "${path.module}/../../src/lambda_function.py"
  output_path = "${path.module}/../../src/lambda_function.zip"
}

resource "aws_lambda_function" "rotation" {
  filename = data.archive_file.lambda.output_path
  function_name = "lambda-secret-rotation"
  role = ""
  handler = "lambda_function.lambda_handler"
  runtime = "python3.14"
  source_code_hash = data.archive_file.lambda.output_base64sha256
  timeout = 30

  vpc_config {
    subnet_ids = var.private-subs-id
    security_group_ids = [var.lambda-sg-id]
  }
}

