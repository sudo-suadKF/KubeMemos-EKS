variable "host-db" {
  description = "RDS DB host"
  type        = string
}

variable "private-subs-id" {
  description = "Private subnets IDs"
  type        = list(string)
}

variable "lambda-sg-id" {
  description = "ID for Lambda SG"
  type        = string
}

variable "secrets-name" {
  description = "Secret name"
  type        = string
}

variable "secrets-alias" {
  description = "Secret KMS key's alias"
  type        = string
}

variable "lambda-function-name" {
  description = "Name of the lambda function"
  type        = string
}

variable "lambda-function-handler" {
  description = "Name of the lambda handler"
  type        = string
}

variable "lambda-function-runtime" {
  description = "Runtime for lambda function"
  type        = string
}

variable "log-level" {
  description = "level of log"
  type        = string
}

variable "log-format" {
  description = "Log format"
  type        = string
}

variable "secrets-manager-endpoint-url" {
  description = "Secrets manager endpoint's URL"
  type        = string
}

variable "lambda-iam-name" {
  description = "lambdas iam role name"
  type        = string
}

variable "lambda-policy-name" {
  description = "lambdas iam policy name"
  type        = string
}

variable "lambda-permission-statement" {
  description = "Lambda permission statement id"
  type        = string
}

variable "lambda-permission-action" {
  description = "Lambda permission action"
  type        = string
}

variable "lambda-permission-principal" {
  description = "Lambda permission principal"
  type        = string
}

variable "postgres-engine" {
  description = "Postgres engine"
  type        = string
  default     = "postgres"
}

variable "db-name" {
  description = "DB name"
  type        = string
  default     = "memosdb"
}

variable "db-username" {
  description = "Username for DB"
  type        = string
  default     = "memosuser"
}
