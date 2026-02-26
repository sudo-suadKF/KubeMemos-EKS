#VPC variables
variable "vpc-cidr-block" {
  description = "Contains VPCs cidr block"
  type        = string
  default     = "10.0.0.0/16"
}

variable "vpc-tags" {
  description = "Contains VPCs tag"
  type        = string
  default     = "my-vpc"
}

variable "igw-tags" {
  description = "Contains IGWs tag"
  type        = string
  default     = "my-igw"
}

variable "nat-gw-mode" {
  description = "Contains NAT GWs avalibality mode"
  type        = string
  default     = "regional"
}

variable "nat-gw-connectivity" {
  description = "Contains NAT GWs connectivity type"
  type        = string
  default     = "public"
}

variable "nat-gw-tags" {
  description = "Contains NAT GWs tag"
  type        = string
  default     = "my-nat-gw"
}

variable "internet-cidr" {
  description = "Contains internet's cidr block"
  type        = string
  default     = "0.0.0.0/0"
}

variable "public-rt-tags" {
  description = "Contains Public RTs tag"
  type        = string
  default     = "public-rt"
}

variable "private-rt-tags" {
  description = "Contains Private RTs tag"
  type        = string
  default     = "private-rt"
}

variable "public-sub1-cidr" {
  description = "Contains public sub1s cidr block"
  type        = string
  default     = "10.0.0.0/19"
}

variable "az1" {
  description = "Contains AZ1"
  type        = string
  default     = "eu-west-2a"
}

variable "public-sub1-tags" {
  description = "Contains public sub1s tag"
  type        = string
  default     = "public-sub1"
}

variable "public-sub2-cidr" {
  description = "Contains public sub2s cidr block"
  type        = string
  default     = "10.0.32.0/19"
}

variable "az2" {
  description = "Contains AZ2"
  type        = string
  default     = "eu-west-2b"
}

variable "public-sub2-tags" {
  description = "Contains public sub2s tag"
  type        = string
  default     = "public-sub2"
}

variable "public-sub3-cidr" {
  description = "Contains public sub3s cidr block"
  type        = string
  default     = "10.0.64.0/19"
}

variable "az3" {
  description = "Contains AZ3"
  type        = string
  default     = "eu-west-2c"
}

variable "public-sub3-tags" {
  description = "Contains public sub3s tag"
  type        = string
  default     = "public.sub3"
}

variable "private-sub1-cidr" {
  description = "Contains private sub1s cidr block"
  type        = string
  default     = "10.0.96.0/19"
}

variable "private-sub1-tags" {
  description = "Contains private sub1s tag"
  type        = string
  default     = "private-sub1"
}

variable "private-sub2-cidr" {
  description = "Contains private sub2s cidr block"
  type        = string
  default     = "10.0.128.0/19"
}

variable "private-sub2-tags" {
  description = "Contains private sub2s tag"
  type        = string
  default     = "private-sub2"
}

variable "private-sub3-cidr" {
  description = "Contains private sub3s cidr block"
  type        = string
  default     = "10.0.160.0/19"
}

variable "private-sub3-tags" {
  description = "Contains private sub3s tag"
  type        = string
  default     = "private-sub3"
}
####################################################################

#EKS variables
variable "addons" {
  description = "Contains addons for cluster"
  type        = list(string)
  default     = ["vpc-cni", "coredns", "kube-proxy", "eks-pod-identity-agent"]
}

variable "eks-cluster-name" {
  description = "Contains eks cluster's name"
  type        = string
  default     = "my-eks-cluster"
}

variable "k8s-version" {
  description = "Contains k8s version"
  type        = string
  default     = "1.35"
}

variable "auth-mode" {
  description = "Contains authentication mode value"
  type        = string
  default     = "API"
}

variable "eks-cluster-iam-role-name" {
  description = "Contains name of eks cluster's IAM role name"
  type        = string
  default     = "eks-cluster-iam-role"
}

variable "eks-cluster-policy-arn" {
  description = "Contains arn of eks cluster policy"
  type        = string
  default     = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

variable "node-group-name" {
  description = "Contains node group name"
  type        = string
  default     = "my-node-group"
}

variable "desired-size" {
  description = "Contains desired size of node groups"
  type        = number
  default     = 3
}

variable "max-size" {
  description = "Contains max size of node groups"
  type        = number
  default     = 4
}

variable "min-size" {
  description = "Contains min size of node groups"
  type        = number
  default     = 1
}

variable "max-unavailable" {
  description = "Contains max unavailable number of node group during update"
  type        = number
  default     = 1
}

variable "node-group-iam-role-name" {
  description = "Contains name of iam role for worker nodes"
  type        = string
  default     = "eks-node-group-role"
}

variable "eks-worker-node-policy-arn" {
  description = "Contains arn of worker node policy"
  type        = string
  default     = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}

variable "eks-cni-policy-arn" {
  description = "Contains arn of cni policy"
  type        = string
  default     = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}

variable "ecr-policy-arn" {
  description = "Contains arn of ecr policy"
  type        = string
  default     = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

variable "aws-account-id" {
  description = "Contains AWS account id"
  type        = string
}

variable "cluster-log-types" {
  description = "Contains cluster log types"
  type        = list(string)
  default     = ["api", "audit", "authenticator", "controllerManager", "scheduler"]
}

variable "secrets" {
  description = "Contains resource's secrets"
  type        = string
  default     = "secrets"
}

variable "kms-eks-description" {
  description = "Contains the description of kms key for eks cluster"
  type        = string
  default     = "KMS key for EKS encryption"
}

variable "kms-alias-eks-name" {
  description = "Contains the alias name"
  type        = string
  default     = "alias/eks-secrets"
}
