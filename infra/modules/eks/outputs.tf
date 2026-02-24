output "eks-cluster-sg-id" {
  value = aws_eks_cluster.my-eks-cluster.vpc_config[0].cluster_security_group_id
}
