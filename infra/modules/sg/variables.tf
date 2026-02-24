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
