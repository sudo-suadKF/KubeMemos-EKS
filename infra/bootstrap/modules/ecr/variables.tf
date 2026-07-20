variable "ecr-repo-name" {
  description = "Contains ECR repo's name"
  type        = string
}

variable "ecr-repo-tag-mutability" {
  description = "Contains ECR repo's tag mutability value"
  type        = string
}

variable "type-kms" {
  description = "Encryption type KMS"
  type        = string
}

variable "ecr-kms-alias" {
  description = "Alias KMS for ECR"
  type        = string
}

variable "ecr-kms-description" {
  description = "ECR's KMS description"
  type        = string
}
