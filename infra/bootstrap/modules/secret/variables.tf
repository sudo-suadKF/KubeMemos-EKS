variable "secret-name" {
  description = "Secret name"
  type        = string
}

variable "secret-kms-description" {
  description = "Secret's kms key description"
  type        = string
}

variable "secret-alias" {
  description = "Secret KMS key's alias"
  type        = string
}