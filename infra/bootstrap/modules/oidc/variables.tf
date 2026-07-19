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

variable "github-url" {
  description = "URL for github to connect with OIDC"
  type = string
}

variable "list-sts" {
  description = "Client id list"
  type = string
}

variable "oidc-tag" {
  description = "Tag for OIDC"
  type = string
}

variable "oidc-iam-name" {
  description = "OIDC IAM name"
  type = string
}

variable "ecr-iam-name" {
  description = "ECR IAM name"
  type = string
}

variable "tf-iam-name" {
  description = "TF IAM name"
  type = string
}

variable "cicd-iam-name" {
  description = "CI/CD guardrails iam name"
  type = string
}