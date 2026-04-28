variable "private-subs-id" {
  description = "Contains private subnets IDs"
  type        = list(string)
}

variable "rds-sg-id" {
  description = "Contains rds sg ID"
  type        = string
}

variable "aws-account-id" {
  description = "Contains AWS account id"
  type        = string
}