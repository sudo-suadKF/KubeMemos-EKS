variable "private-subs-id" {
  description = "Contains private subnets IDs"
  type        = list(string)
}

variable "rds-sg-id" {
  description = "Contains rds sg ID"
  type        = string
}