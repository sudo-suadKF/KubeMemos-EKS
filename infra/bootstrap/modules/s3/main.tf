data "aws_caller_identity" "current" {}

resource "aws_s3_bucket" "eks-bootstrap" {
  bucket = var.s3-bucket-name

  tags = {
    Name = var.s3-bucket-tag
  }
}

resource "aws_s3_bucket_ownership_controls" "disable-acl" {
  bucket = aws_s3_bucket.eks-bootstrap.id

  rule {
    object_ownership = var.s3-bucket-object-ownership
  }
}

resource "aws_s3_bucket_public_access_block" "access-denied" {
  bucket = aws_s3_bucket.eks-bootstrap.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_versioning" "enabled" {
  bucket = aws_s3_bucket.eks-bootstrap.id

  versioning_configuration {
    status = var.s3-bucket-versioning-status
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "sse-s3" {
  bucket = aws_s3_bucket.eks-bootstrap.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = var.s3-bucket-sse-algorithm
      kms_master_key_id = aws_kms_key.s3-tf-state.arn
    }
    bucket_key_enabled = true
  }
}

resource "aws_s3_bucket_policy" "encryption" {
  bucket = aws_s3_bucket.eks-bootstrap.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "DenyNonSSLAccess"
        Effect    = "Deny"
        Principal = "*"
        Action    = "s3:*"
        Resource = [
          aws_s3_bucket.eks-bootstrap.arn,
          "${aws_s3_bucket.eks-bootstrap.arn}/*"
        ]
        Condition = {
          Bool = {
            "aws:SecureTransport" = "false"
          }
        }
      },
      {
        Sid       = "DenyIncorrectEncryption"
        Effect    = "Deny"
        Principal = "*"
        Action    = "s3:PutObject"
        Resource  = "${aws_s3_bucket.eks-bootstrap.arn}/*"
        Condition = {
          StringNotEquals = {
            "s3:x-amz-server-side-encryption-aws-kms-key-id" = aws_kms_key.s3-tf-state.arn
          }
        }
      }
    ]
  })
}

resource "aws_kms_key" "s3-tf-state" {
  description         = "KMS key for TF state file encryption"
  enable_key_rotation = true
  multi_region        = false

  policy = jsonencode({
    Version = "2012-10-17"
    Id      = "terraform-state-key-policy"
    Statement = [
      {
        Sid    = "EnableRootAccountAccess"
        Effect = "Allow"
        Principal = {
          AWS = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
        }
        Action   = "kms:*"
        Resource = "*"
      },
      {
        Sid    = "AllowTerraformAccess"
        Effect = "Allow"
        Principal = {
          AWS = [
            var.oidc-role-arn,
            "arn:aws:iam::${data.aws_caller_identity.current.account_id}:user/SudoSuad"
          ]
        }
        Action = [
          "kms:Encrypt",
          "kms:Decrypt",
          "kms:ReEncrypt*",
          "kms:GenerateDataKey*",
          "kms:DescribeKey"
        ]
        Resource = "*"
      },
      {
        Sid    = "Allow S3 Service"
        Effect = "Allow"
        Principal = {
          Service = "s3.amazonaws.com"
        }
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

resource "aws_kms_alias" "tf-state" {
  name          = "alias/tf-state"
  target_key_id = aws_kms_key.s3-tf-state.key_id
}
