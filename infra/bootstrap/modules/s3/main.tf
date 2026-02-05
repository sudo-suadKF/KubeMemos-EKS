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
      sse_algorithm = var.s3-bucket-sse-algorithm
    }
  }
}
