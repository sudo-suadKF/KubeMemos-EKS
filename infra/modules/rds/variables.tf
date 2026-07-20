variable "private-subs-id" {
  description = "Contains private subnets IDs"
  type        = list(string)
}

variable "rds-sg-id" {
  description = "Contains rds sg ID"
  type        = string
}

variable "random-password" {
  description = "Contains random password"
  type        = string
  sensitive   = true
}

variable "db-subnet-group-name" {
  description = "Name for db subnet group"
  type        = string
}

variable "db-subnet-group-description" {
  description = "DB Subnet group description"
  type        = string
}

variable "db-subnet-group-tag" {
  description = "Tag for db subnet group"
  type        = string
}

variable "db-identifier" {
  description = "DB instance identifier"
  type        = string
}

variable "postgres-engine" {
  description = "Postgres engine"
  type        = string
}

variable "instance-class" {
  description = "Instance class"
  type        = string
}

variable "storage-type" {
  description = "Storage type for db"
  type        = string
}

variable "db-name" {
  description = "DB name"
  type        = string
}

variable "db-username" {
  description = "Username for DB"
  type        = string
}

variable "db-param-group-description" {
  description = "Description of db parameter group"
  type        = string
}

variable "db-param-group-name-prefix" {
  description = "Name prefix for db parameter group"
  type        = string
}

variable "db-param-group-family" {
  description = "Family for db parameter group"
  type        = string
}

variable "rds-kms-description" {
  description = "Description of KMS key for RDS"
  type        = string
}

variable "rd-kms-alias-name" {
  description = "kms alias name for rds"
  type        = string
}

variable "rds-monitoring-iam-name" {
  description = "Name for rds monitoring IAM role"
  type        = string
}