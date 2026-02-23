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
  default     = "my-nay-gw"
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
