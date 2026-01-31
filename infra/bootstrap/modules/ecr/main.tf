resource "aws_ecr_repository" "eks-docker-image" {
  name                 = "kube2048-eks"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}