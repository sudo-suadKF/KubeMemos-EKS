variable "ecr-repo-name" {
  description = "Contains ECR repo's name"
  type        = string
  default     = "kube-memo-eks"
}

variable "ecr-repo-tag-mutability" {
  description = "Contains ECR repo's tag mutability value"
  type        = string
  default     = "IMMUTABLE"
}

variable "type-kms" {
  description = "Encryption type KMS"
  type        = string
  default     = "KMS"
}

variable "ecr-kms-alias" {
  description = "Alias KMS for ECR"
  type        = string
  default     = "alias/ecr"
}

variable "ecr-kms-description" {
  description = "ECR's KMS description"
  type        = string
  default     = "KMS key for ECR encryption"
}

variable "s3-bucket-name" {
  description = "Contains s3 bucket's name"
  type        = string
  default     = "eks-bootstrap-bucket-for-terraform-state"
}

variable "s3-bucket-tag" {
  description = "Contains s3 bucket's tag"
  type        = string
  default     = "EKS bootstrap bucket"
}

variable "s3-bucket-object-ownership" {
  description = "Contains object ownership's value"
  type        = string
  default     = "BucketOwnerEnforced"
}

variable "s3-bucket-versioning-status" {
  description = "Contains versioning status value"
  type        = string
  default     = "Enabled"
}

variable "s3-bucket-sse-algorithm" {
  description = "Contains sse algorithm's value"
  type        = string
  default     = "aws:kms"
}

variable "tf-state-kms-description" {
  description = "TF state KMS description"
  type        = string
  default     = "KMS key for TF state file encryption"
}

variable "tf-state-alias" {
  description = "TF state's KMS alias"
  type        = string
  default     = "alias/tf-state"
}

variable "github-url" {
  description = "URL for github to connect with OIDC"
  type        = string
  default     = "https://token.actions.githubusercontent.com"
}

variable "list-sts" {
  description = "Client id list"
  type        = string
  default     = "sts.amazonaws.com"
}

variable "oidc-tag" {
  description = "Tag for OIDC"
  type        = string
  default     = "github-actions-oidc"
}

variable "oidc-iam-name" {
  description = "OIDC IAM name"
  type        = string
  default     = "github-actions-oidc-role"
}

variable "ecr-iam-name" {
  description = "ECR IAM name"
  type        = string
  default     = "ecr-access-policy"
}

variable "tf-iam-name" {
  description = "TF IAM name"
  type        = string
  default     = "terraform-permission-policy"
}

variable "cicd-iam-name" {
  description = "CI/CD guardrails iam name"
  type        = string
  default     = "cicd-guardrails"
}