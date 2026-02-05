variable "ecr-repo-name" {
  description = "Contains ECR repo's name"
  type        = string
  default     = "kube2048-eks"
}

variable "ecr-repo-tag-mutability" {
  description = "Contains ECR repo's tag mutability value"
  type        = string
  default     = "MUTABLE"
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
  default     = "AES256"
}
