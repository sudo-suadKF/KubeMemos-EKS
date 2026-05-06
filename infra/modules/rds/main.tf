resource "aws_db_subnet_group" "rds-private-subnets" {
  name        = "rds-private-subnets"
  description = "Subnet group for rds"
  subnet_ids  = var.private-subs-id

  tags = {
    Name = "rds-private-subnets"
  }
}

resource "aws_db_instance" "postgres-rds" {
  identifier           = "production-rds"
  db_subnet_group_name = aws_db_subnet_group.rds-private-subnets.name
  vpc_security_group_ids = [ var.rds-sg-id ]
  publicly_accessible = false
  port = 5432

  engine               = "postgres"
  engine_version       = "18"
  instance_class       = "db.t3.micro"
  allow_major_version_upgrade = false
  auto_minor_version_upgrade = true

  storage_type = "gp3"
  allocated_storage    = 20
  max_allocated_storage = 50

  storage_encrypted = true
  kms_key_id = aws_kms_key.rds-kms.arn
  
  multi_az = true

  db_name              = "postgresrds"
  username             = "memosuser"
  password = "memospassword"
  #manage_master_user_password = true
  #iam_database_authentication_enabled = true

  enabled_cloudwatch_logs_exports = ["postgresql", "upgrade", "iam-db-auth-error"]
  monitoring_interval = 60
  monitoring_role_arn = aws_iam_role.rds-monitoring-role.arn
  performance_insights_enabled = true
  performance_insights_retention_period = 7
  performance_insights_kms_key_id = aws_kms_key.rds-kms.arn

  parameter_group_name = aws_db_parameter_group.postgres-parameter-group.name
  skip_final_snapshot  = true
}

resource "aws_db_parameter_group" "postgres-parameter-group" {
  description = "memos-postgres-parameter-group"
  name_prefix = "memos-postgres18"
  family = "postgres18"

  parameter {
    name = "rds.force_ssl"
    value = "1"
    apply_method = "immediate"
  }

  parameter {
    name = "log_connections"
    value = "all"
    apply_method = "immediate"
  }

  parameter {
    name = "log_disconnections"
    value = "1"
    apply_method = "immediate"
    }

  parameter {
    name = "log_statement"
    value = "ddl"
    apply_method = "immediate"
  }

  parameter {
    name = "log_min_duration_statement"
    value = "1000"
    apply_method = "immediate"
  }

  parameter {
    name = "password_encryption"
    value = "scram-sha-256"
    apply_method = "immediate"
  }

  parameter {
    name = "max_connections"
    value = "200"
    apply_method = "pending-reboot"
  }
    

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_kms_key" "rds-kms" {
  description             = "KMS key for RDS database encryption"
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
          AWS = "arn:aws:iam::${var.aws-account-id}:root"
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
  name          = "alias/memos-rds"
  target_key_id = aws_kms_key.rds-kms.key_id
}

resource "aws_iam_role" "rds-monitoring-role" {
  name = "rds-monitoring"

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
  role = aws_iam_role.rds-monitoring-role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonRDSEnhancedMonitoringRole"
}