variable "eks-cluster-name" {
  description = "EKS cluster name"
  type        = string
}

variable "my-hosted-zone-name" {
  description = "Hosted zone name"
  type        = string
}

variable "iam-role-pod-identity-name" {
  description = "Name of the iam role for pod identity"
  type        = string
}

variable "external-dns" {
  description = "Word external dns"
  type        = string
}

variable "iam-role-pod-identity-tags" {
  description = "Tag for iam role po identity"
  type        = string
}
