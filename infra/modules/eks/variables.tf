variable "public-subs-id" {
  description = "Contains public subnets IDs"
  type        = list(string)
}

variable "private-subs-id" {
  description = "Contains private subnets IDs"
  type        = list(string)
}

variable "addons" {
  description = "Contains addons for cluster"
  type        = list(string)
}

variable "eks-cluster-name" {
  description = "Contains eks cluster's name"
  type        = string
}

variable "k8s-version" {
  description = "Contains k8s version"
  type        = string
}

variable "auth-mode" {
  description = "Contains authentication mode value"
  type        = string
}

variable "internet-cidr" {
  description = "Contains internet's cidr"
  type        = string
}

variable "eks-cluster-iam-role-name" {
  description = "Contains name of eks cluster's IAM role name"
  type        = string
}

variable "eks-cluster-policy-arn" {
  description = "Contains arn of eks cluster policy"
  type        = string
}

variable "node-group-name" {
  description = "Contains node group name"
  type        = string
}

variable "desired-size" {
  description = "Contains desired size of node groups"
  type        = number
}

variable "max-size" {
  description = "Contains max size of node groups"
  type        = number
}

variable "min-size" {
  description = "Contains min size of node groups"
  type        = number
}

variable "max-unavailable" {
  description = "Contains max unavailable number of node group during update"
  type        = number
}

variable "node-group-iam-role-name" {
  description = "Contains name of iam role for worker nodes"
  type        = string
}

variable "eks-worker-node-policy-arn" {
  description = "Contains arn of worker node policy"
  type        = string
}

variable "eks-cni-policy-arn" {
  description = "Contains arn of cni policy"
  type        = string
}

variable "ecr-policy-arn" {
  description = "Contains arn of ecr policy"
  type        = string
}

variable "aws-account-id" {
  description = "Contains AWS account id"
  type        = string
}

variable "cluster-log-types" {
  description = "Contains cluster log types"
  type        = list(string)
}

variable "secrets" {
  description = "Contains resource's secrets"
  type        = string
}

variable "kms-eks-description" {
  description = "Contains the description of kms key for eks cluster"
  type        = string
}

variable "kms-alias-eks-name" {
  description = "Contains the alias name"
  type        = string
}

variable "delete-window" {
  description = "Days to delete"
  type        = number
}
