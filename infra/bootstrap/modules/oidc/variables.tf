variable "ecr-repo-arn" {
  description = "ECR repo's ARN value"
  type        = string
}

variable "s3-bucket-arn" {
  description = "S3 bucket's ARN value"
  type        = string
}

variable "s3-kms-key-arn" {
  description = "S3 kms key's ARN value"
  type        = string
}