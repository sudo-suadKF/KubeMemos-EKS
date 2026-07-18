variable "s3-bucket-name" {
  description = "Contains s3 bucket's name"
  type        = string
}

variable "s3-bucket-tag" {
  description = "Contains s3 bucket's tag"
  type        = string
}

variable "s3-bucket-object-ownership" {
  description = "Contains object ownership's value"
  type        = string
}

variable "s3-bucket-versioning-status" {
  description = "Contains versioning status value"
  type        = string
}

variable "s3-bucket-sse-algorithm" {
  description = "Contains sse algorithm's value"
  type        = string
}
