variable "vpc-id" {
  description = "Contains VPC id"
  type        = string
}

variable "eks-cluster-sg-id" {
  description = "Contains eks cluster sg id"
  type        = string
}

variable "internet-cidr" {
  description = "Contains internet's cidr"
  type        = string
}

variable "ip-protocol-tcp" {
  description = "TCP protocol"
  type        = string
}

variable "ip-protocol_-1" {
  description = "Ip protocol -1, all traffic"
  type        = string
}

variable "vpc-cidr" {
  description = "VPC's cidr block"
  type        = string
}

variable "rds-sg-name" {
  description = "Name of SG RDS"
  type        = string
}

variable "rds-sg-description" {
  description = "Description of rds sg"
  type        = string
}

variable "rds-sg-tag" {
  description = "Tag of rds sg"
  type        = string
}

variable "lambda-sg-name" {
  description = "Name of SG lambda"
  type        = string
}

variable "lambda-sg-description" {
  description = "Description of lambda sg"
  type        = string
}

variable "lambda-sg-tag" {
  description = "Tag of lambda sg"
  type        = string
}

variable "vpc-endpoints-sg-name" {
  description = "Name of SG vpc-endpoints"
  type        = string
}

variable "vpc-endpoints-sg-description" {
  description = "Description of vpc-endpoints sg"
  type        = string
}

variable "vpc-endpoints-sg-tag" {
  description = "Tag of vpc-endpoints sg"
  type        = string
}
