resource "aws_ecr_repository" "eks-docker-image" {
  name                 = var.ecr-repo-name
  image_tag_mutability = var.ecr-repo-tag-mutability

  image_scanning_configuration {
    scan_on_push = true
  }
}
