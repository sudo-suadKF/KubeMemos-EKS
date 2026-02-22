variable "public-subs-id" {
  description = "Contains public subnets IDs"
  type        = list(string)
}

variable "addons" {
  description = "Contains addons for cluster"
  type        = list(string)
  default     = ["vpc-cni", "coredns", "kube-proxy", "eks-pod-identity-agent"]
}
