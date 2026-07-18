output "s3-bucket-arn" {
  value = aws_s3_bucket.eks-bootstrap.arn
}

output "s3-kms-key-arn" {
  value = aws_kms_key.s3-tf-state.arn
}