variable "vpc-cidr-block" {
  description = "Contains VPCs cidr block"
  type        = string
}

variable "vpc-tags" {
  description = "Contains VPCs tag"
  type        = string
}

variable "igw-tags" {
  description = "Contains IGWs tag"
  type        = string
}

variable "nat-gw-mode" {
  description = "Contains NAT GWs avalibality mode"
  type        = string
}

variable "nat-gw-connectivity" {
  description = "Contains NAT GWs connectivity type"
  type        = string
}

variable "nat-gw-tags" {
  description = "Contains NAT GWs tag"
  type        = string
}

variable "internet-cidr" {
  description = "Contains internet's cidr block"
  type        = string
}

variable "public-rt-tags" {
  description = "Contains Public RTs tag"
  type        = string
}

variable "private-rt-tags" {
  description = "Contains Private RTs tag"
  type        = string
}

variable "public-sub1-cidr" {
  description = "Contains public sub1s cidr block"
  type        = string
}

variable "az1" {
  description = "Contains AZ1"
  type        = string
}

variable "public-sub1-tags" {
  description = "Contains public sub1s tag"
  type        = string
}

variable "public-sub2-cidr" {
  description = "Contains public sub2s cidr block"
  type        = string
}

variable "az2" {
  description = "Contains AZ2"
  type        = string
}

variable "public-sub2-tags" {
  description = "Contains public sub2s tag"
  type        = string
}

variable "public-sub3-cidr" {
  description = "Contains public sub3s cidr block"
  type        = string
}

variable "az3" {
  description = "Contains AZ3"
  type        = string
}

variable "public-sub3-tags" {
  description = "Contains public sub3s tag"
  type        = string
}

variable "private-sub1-cidr" {
  description = "Contains private sub1s cidr block"
  type        = string
}

variable "private-sub1-tags" {
  description = "Contains private sub1s tag"
  type        = string
}

variable "private-sub2-cidr" {
  description = "Contains private sub2s cidr block"
  type        = string
}

variable "private-sub2-tags" {
  description = "Contains private sub2s tag"
  type        = string
}

variable "private-sub3-cidr" {
  description = "Contains private sub3s cidr block"
  type        = string
}

variable "private-sub3-tags" {
  description = "Contains private sub3s tag"
  type        = string
}
