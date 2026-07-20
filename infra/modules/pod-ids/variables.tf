variable "eks-cluster-name" {
  description = "EKS cluster name"
  type        = string
}

variable "my-hosted-zone-name" {
  description = "Hosted zone name"
  type        = string
}

variable "iam-role-pod-id-dns-name" {
  description = "Name of the iam role for pod identity"
  type        = string
}

variable "external-dns" {
  description = "Word external dns"
  type        = string
}

variable "iam-role-pod-id-dns-tags" {
  description = "Tag for iam role po identity"
  type        = string
}

variable "secret-name" {
  description = "Secret name"
  type        = string
}

variable "secret-alias" {
  description = "Alias for secrets manager kms key"
  type        = string
}

variable "external-secret-pod-id-name" {
  description = "External secret's pod id name"
  type        = string
}

variable "external-secret-pod-id-tag" {
  description = "External secret's pod id tag"
  type        = string
}

variable "external-secret-policy-name" {
  description = "External secret's policy name"
  type        = string
}

variable "external-secrets" {
  description = "Name external secret"
  type        = string
}
