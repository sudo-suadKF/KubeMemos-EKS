data "aws_caller_identity" "current" {}

resource "aws_ecr_repository" "eks-docker-image" {
  name                 = var.ecr-repo-name
  image_tag_mutability = var.ecr-repo-tag-mutability

  image_scanning_configuration {
    scan_on_push = true
  }

  encryption_configuration {
    encryption_type = "KMS"
    kms_key         = aws_kms_key.ecr-encrypt.arn
  }
}

resource "aws_kms_key" "ecr-encrypt" {
  description             = "KMS key for ECR encryption"
  enable_key_rotation     = true
  deletion_window_in_days = 7

  policy = jsonencode({
    Version = "2012-10-17"
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
          Service = "ecr.amazonaws.com"
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

resource "aws_kms_alias" "ecr" {
  name          = var.ecr-kms-alias
  target_key_id = aws_kms_key.ecr-encrypt.id
}
