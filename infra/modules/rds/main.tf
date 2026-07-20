data "aws_caller_identity" "current" {}

resource "aws_db_subnet_group" "rds-private-subnets" {
  name        = var.db-subnet-group-name
  description = var.db-subnet-group-description
  subnet_ids  = var.private-subs-id

  tags = {
    Name = var.db-subnet-group-tag
  }
}

resource "aws_db_instance" "postgres-rds" {
  identifier             = var.db-identifier
  db_subnet_group_name   = aws_db_subnet_group.rds-private-subnets.name
  vpc_security_group_ids = [var.rds-sg-id]
  publicly_accessible    = false
  port                   = 5432

  engine                      = var.postgres-engine
  engine_version              = 18
  instance_class              = var.instance-class
  allow_major_version_upgrade = false
  auto_minor_version_upgrade  = true

  storage_type          = var.storage-type
  allocated_storage     = 20
  max_allocated_storage = 50

  storage_encrypted = true
  kms_key_id        = aws_kms_key.rds-kms.arn

  multi_az = true

  db_name  = var.db-name
  username = var.db-username
  password = var.random-password

  enabled_cloudwatch_logs_exports       = ["postgresql", "upgrade", "iam-db-auth-error"]
  monitoring_interval                   = 60
  monitoring_role_arn                   = aws_iam_role.rds-monitoring-role.arn
  performance_insights_enabled          = true
  performance_insights_retention_period = 7
  performance_insights_kms_key_id       = aws_kms_key.rds-kms.arn

  parameter_group_name = aws_db_parameter_group.postgres-parameter-group.name
  skip_final_snapshot  = true

  lifecycle {
    ignore_changes = [password]
  }
}

resource "aws_db_parameter_group" "postgres-parameter-group" {
  description = var.db-param-group-description
  name_prefix = var.db-param-group-name-prefix
  family      = var.db-param-group-family

  parameter {
    name         = "rds.force_ssl"
    value        = "1"
    apply_method = "immediate"
  }

  parameter {
    name         = "log_connections"
    value        = "all"
    apply_method = "immediate"
  }

  parameter {
    name         = "log_disconnections"
    value        = "1"
    apply_method = "immediate"
  }

  parameter {
    name         = "log_statement"
    value        = "ddl"
    apply_method = "immediate"
  }

  parameter {
    name         = "log_min_duration_statement"
    value        = "1000"
    apply_method = "immediate"
  }

  parameter {
    name         = "password_encryption"
    value        = "scram-sha-256"
    apply_method = "immediate"
  }

  parameter {
    name         = "max_connections"
    value        = "200"
    apply_method = "pending-reboot"
  }


  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_kms_key" "rds-kms" {
  description             = var.rds-kms-description
  deletion_window_in_days = 7
  enable_key_rotation     = true

  policy = jsonencode({
    Version = "2012-10-17"
    Id      = "key-default-1"
    Statement = [
      {
        Sid    = "Enable IAM User Permissions"
        Effect = "Allow"
        Principal = {
          AWS = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
        },
        Action   = "kms:*"
        Resource = "*"
      },
      {
        Sid    = "Allow use of the key"
        Effect = "Allow"
        Principal = {
          Service = "rds.amazonaws.com"
        },
        Action = [
          "kms:DescribeKey",
          "kms:Encrypt",
          "kms:Decrypt",
          "kms:ReEncrypt*",
          "kms:GenerateDataKey",
          "kms:GenerateDataKeyWithoutPlaintext"
        ],
        Resource = "*"
      }
    ]
  })
}

resource "aws_kms_alias" "rds" {
  name          = var.rd-kms-alias-name
  target_key_id = aws_kms_key.rds-kms.key_id
}

resource "aws_iam_role" "rds-monitoring-role" {
  name = var.rds-monitoring-iam-name

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "monitoring.rds.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "rds-monitoring-policy" {
  role       = aws_iam_role.rds-monitoring-role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole"
}
