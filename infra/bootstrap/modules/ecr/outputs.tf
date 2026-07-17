output "ecr-repo-arn" {
  value = aws_ecr_repository.eks-docker-image.arn
}