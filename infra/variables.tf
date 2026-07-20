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

variable "node-sg-name" {
  description = "Name of node sg"
  type        = string
  default     = "node-sg"
}

variable "node-sg-description" {
  description = "Description of node sg"
  type        = string
  default     = "sg for eks worker nodes"
}

variable "node-sg-tags" {
  description = "Tags of node sg"
  type        = string
  default     = "eks-node-sg"
}

variable "ingress-rule-cluster-node-description" {
  description = "Description of ingress rule of cluster to node"
  type        = string
  default     = "ingress for cluster api to worker node"
}

variable "ip-protocol-tcp" {
  description = "TCP protocol"
  type        = string
  default     = "tcp"
}

variable "port-HTTPS" {
  description = "Port number of HTTPS"
  type        = number
  default     = 443
}

variable "ingress-rule-cluster-kubelet-description" {
  description = "Description of ingress rule of cluster to kubelet"
  type        = string
  default     = "ingress for cluster api to kubelet"
}

variable "port-10250" {
  description = "Port number 10250"
  type        = number
  default     = 10250
}

variable "ingress-rule-node-node-TCP-description" {
  description = "Description of ingress rule of node to node TCP"
  type        = string
  default     = "ingress for node to node TCP communication"
}

variable "port-DNS" {
  description = "Port number 53"
  type        = number
  default     = 53
}

variable "ingress-rule-node-node-UDP-description" {
  description = "Description of ingress rule of node to node UDP"
  type        = string
  default     = "ingress for node to node UDP communication"
}

variable "egress-rule-node-description" {
  description = "Description of ingress rule of node to node UDP"
  type        = string
  default     = "egress for worker node to internet"
}

variable "ip-protocol_-1" {
  description = "Ip protocol -1, all traffic"
  type        = string
  default     = "-1"
}

variable "ip-protocol-udp" {
  description = "UDP protocol"
  type        = string
  default     = "udp"
}

variable "delete-window" {
  description = "Days to delete"
  type        = number
  default     = 7
}

variable "my-hosted-zone-name" {
  description = "Hosted zone name"
  type        = string
  default     = "sudosuad.co.uk"
}

variable "iam-role-pod-id-dns-name" {
  description = "Name of the iam role for pod identity"
  type        = string
  default     = "eks-pod-id-role-dns"
}

variable "external-dns" {
  description = "Word external dns"
  type        = string
  default     = "external-dns"
}

variable "iam-role-pod-id-dns-tags" {
  description = "Tag for iam role po identity"
  type        = string
  default     = "Pod Identity ExternalDNS"
}

variable "secrets-name" {
  description = "Secret name"
  type        = string
  default     = "production/rds/credentials"
}

variable "secrets-alias" {
  description = "Alias for secrets manager kms key"
  type        = string
  default     = "alias/secrets-manager"
}

variable "external-secret-pod-id-name" {
  description = "External secret's pod id name"
  type        = string
  default     = "eks-pod-id-role-secrets"
}

variable "external-secret-pod-id-tag" {
  description = "External secret's pod id tag"
  type        = string
  default     = "Pod ID ExternalSecrets"
}

variable "external-secret-policy-name" {
  description = "External secret's policy name"
  type        = string
  default     = "external-secrets-policy"
}

variable "external-secrets" {
  description = "Name external secret"
  type        = string
  default     = "external-secrets"
}

variable "db-subnet-group-name" {
  description = "Name for db subnet group"
  type        = string
  default     = "rds-private-subnets"
}

variable "db-subnet-group-description" {
  description = "DB Subnet group description"
  type        = string
  default     = "Subnet group for rds"
}

variable "db-subnet-group-tag" {
  description = "Tag for db subnet group"
  type        = string
  default     = "rds-private-subnets"
}

variable "db-identifier" {
  description = "DB instance identifier"
  type        = string
  default     = "production-rds"
}

variable "postgres-engine" {
  description = "Postgres engine"
  type        = string
  default     = "postgres"
}

variable "instance-class" {
  description = "Instance class"
  type        = string
  default     = "db.t3.micro"
}

variable "storage-type" {
  description = "Storage type for db"
  type        = string
  default     = "gp3"
}

variable "db-name" {
  description = "DB name"
  type        = string
  default     = "memosdb"
}

variable "db-username" {
  description = "Username for DB"
  type        = string
  default     = "memosuser"
}

variable "db-param-group-description" {
  description = "Description of db parameter group"
  type        = string
  default     = "memos-postgres-parameter-group"
}

variable "db-param-group-name-prefix" {
  description = "Name prefix for db parameter group"
  type        = string
  default     = "memos-postgres18"
}

variable "db-param-group-family" {
  description = "Family for db parameter group"
  type        = string
  default     = "postgres18"
}

variable "rds-kms-description" {
  description = "Description of KMS key for RDS"
  type        = string
  default     = "KMS key for RDS database encryption"
}

variable "rd-kms-alias-name" {
  description = "kms alias name for rds"
  type        = string
  default     = "alias/memos-rds"
}

variable "rds-monitoring-iam-name" {
  description = "Name for rds monitoring IAM role"
  type        = string
  default     = "rds-monitoring"
}

variable "secret-name" {
  description = "Secret name"
  type        = string
  default     = "production/rds/credentials"
}

variable "secret-alias" {
  description = "Secret KMS key's alias"
  type        = string
  default     = "alias/secrets-manager"
}

variable "lambda-function-name" {
  description = "Name of the lambda function"
  type        = string
  default     = "lambda-secret-rotation"
}

variable "lambda-function-handler" {
  description = "Name of the lambda handler"
  type        = string
  default     = "lambda_function.lambda_handler"
}

variable "lambda-function-runtime" {
  description = "Runtime for lambda function"
  type        = string
  default     = "python3.14"
}

variable "log-level" {
  description = "level of log"
  type        = string
  default     = "INFO"
}

variable "log-format" {
  description = "Log format"
  type        = string
  default     = "JSON"
}

variable "secrets-manager-endpoint-url" {
  description = "Secrets manager endpoint's URL"
  type        = string
  default     = "https://secretsmanager.eu-west-2.amazonaws.com"
}

variable "lambda-iam-name" {
  description = "lambdas iam role name"
  type        = string
  default     = "lambda-secret-rotation-role"
}

variable "lambda-policy-name" {
  description = "lambdas iam policy name"
  type        = string
  default     = "lambda-rotation-policy"
}

variable "lambda-permission-statement" {
  description = "Lambda permission statement id"
  type        = string
  default     = "AllowSecretsManagerInvoke"
}

variable "lambda-permission-action" {
  description = "Lambda permission action"
  type        = string
  default     = "lambda:InvokeFunction"
}

variable "lambda-permission-principal" {
  description = "Lambda permission principal"
  type        = string
  default     = "secretsmanager.amazonaws.com"
}

variable "rds-sg-name" {
  description = "Name of SG RDS"
  type        = string
  default     = "rds-sg"
}

variable "rds-sg-description" {
  description = "Description of rds sg"
  type        = string
  default     = "sg for rds db instance"
}

variable "rds-sg-tag" {
  description = "Tag of rds sg"
  type        = string
  default     = "rds-sg"
}

variable "lambda-sg-name" {
  description = "Name of SG lambda"
  type        = string
  default     = "lambda-sg"
}

variable "lambda-sg-description" {
  description = "Description of lambda sg"
  type        = string
  default     = "sg for lambda"
}

variable "lambda-sg-tag" {
  description = "Tag of lambda sg"
  type        = string
  default     = "lambda-sg"
}

variable "vpc-endpoints-sg-name" {
  description = "Name of SG vpc-endpoints"
  type        = string
  default     = "vpc-endpoints-sg"
}

variable "vpc-endpoints-sg-description" {
  description = "Description of vpc-endpoints sg"
  type        = string
  default     = "sg for vpc-endpoints"
}

variable "vpc-endpoints-sg-tag" {
  description = "Tag of vpc-endpoints sg"
  type        = string
  default     = "vpc-endpoints-sg"
}

variable "interface-endpoint-type" {
  description = "Interface endpoint type"
  type        = string
  default     = "Interface"
}

variable "s3-service-name" {
  description = "S3 service name for gateway endpoint"
  type        = string
  default     = "com.amazonaws.eu-west-2.s3"
}

variable "gateway-endpoint-type" {
  description = "Gateway endpoint type"
  type        = string
  default     = "Gateway"
}

variable "s3-endpoint-tag" {
  description = "Tag for s3 endpoint"
  type        = string
  default     = "s3-endpoint"
}
