data "aws_secretsmanager_secret" "rds-credentials" {
  name = var.secrets-name
}

data "aws_kms_key" "by_alias" {
  key_id = var.secrets-alias
}

resource "random_password" "rds-password" {
  length           = 32
  special          = true
  override_special = "!#$^&*()-_=+[]{}|:,.<>?"
  # Avoid characters that cause issues in connection strings
  min_lower   = 4
  min_upper   = 4
  min_numeric = 4
  min_special = 2
}

resource "aws_secretsmanager_secret_version" "rds-credentials" {
  secret_id = data.aws_secretsmanager_secret.rds-credentials.id

  secret_string = jsonencode({
    engine   = var.postgres-engine
    host     = var.host-db
    username = var.db-username
    password = random_password.rds-password.result
    dbname   = var.db-name
    port     = 5432
  })

  lifecycle {
    ignore_changes = [secret_string]
  }
}

resource "aws_secretsmanager_secret_rotation" "rds-credentials" {
  secret_id           = data.aws_secretsmanager_secret.rds-credentials.id
  rotation_lambda_arn = aws_lambda_function.rotation.arn

  rotation_rules {
    automatically_after_days = 30
  }
}

resource "aws_lambda_function" "rotation" {
  filename         = "${path.module}/../../src/lambda.zip"
  function_name    = var.lambda-function-name
  role             = aws_iam_role.lambda.arn
  handler          = var.lambda-function-handler
  runtime          = var.lambda-function-runtime
  source_code_hash = filebase64sha256("${path.module}/../../src/lambda.zip")
  timeout          = 30

  vpc_config {
    subnet_ids         = var.private-subs-id
    security_group_ids = [var.lambda-sg-id]
  }

  logging_config {
    application_log_level = var.log-level
    log_format            = var.log-format
    system_log_level      = var.log-level
  }

  tracing_config {
    mode = "Active"
  }

  environment {
    variables = {
      SECRETS_MANAGER_ENDPOINT = var.secrets-manager-endpoint-url
    }
  }

  depends_on = [aws_iam_role.lambda, aws_iam_role_policy.lambda]
}

resource "aws_iam_role" "lambda" {
  name = var.lambda-iam-name

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }]
  })
}

resource "aws_iam_role_policy" "lambda" {
  name = var.lambda-policy-name
  role = aws_iam_role.lambda.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "secretsmanager:DescribeSecret",
          "secretsmanager:GetSecretValue",
          "secretsmanager:PutSecretValue",
          "secretsmanager:UpdateSecretVersionStage"
        ]
        Resource = data.aws_secretsmanager_secret.rds-credentials.arn
      },
      {
        Effect   = "Allow"
        Action   = "secretsmanager:GetRandomPassword"
        Resource = "*"
      },
      {
        Effect = "Allow"
        Action = [
          "kms:Encrypt",
          "kms:Decrypt",
          "kms:ReEncrypt*",
          "kms:GenerateDataKey*",
          "kms:DescribeKey"
        ]
        Resource = data.aws_kms_key.by_alias.arn
      },
      {
        Effect = "Allow"
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Resource = "arn:aws:logs:*:*:*"
      },
      {
        Effect = "Allow"
        Action = [
          "ec2:CreateNetworkInterface",
          "ec2:DeleteNetworkInterface",
          "ec2:DescribeNetworkInterfaces",
          "ec2:DescribeSubnets",
          "ec2:AssignPrivateIpAddresses",
          "ec2:UnassignPrivateIpAddresses"
        ]
        Resource = "*"
      }
    ]
  })
}

resource "aws_lambda_permission" "secretsmanager" {
  statement_id  = var.lambda-permission-statement
  action        = var.lambda-permission-action
  function_name = aws_lambda_function.rotation.function_name
  principal     = var.lambda-permission-principal
  source_arn    = data.aws_secretsmanager_secret.rds-credentials.arn
}

resource "terraform_data" "initial-rotation" {
  depends_on = [
    aws_lambda_function.rotation,
    aws_lambda_permission.secretsmanager,
    aws_secretsmanager_secret_rotation.rds-credentials,
    aws_secretsmanager_secret_version.rds-credentials
  ]

  provisioner "local-exec" {
    command = <<EOF
      aws secretsmanager rotate-secret \
       --secret-id ${data.aws_secretsmanager_secret.rds-credentials.id} \
       --region eu-west-2 \
       >/dev/null && echo "Initial secret rotation completed."
    EOF
  }
}
