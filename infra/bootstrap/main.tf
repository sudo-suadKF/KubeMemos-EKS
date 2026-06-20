module "ecr" {
  source                  = "./modules/ecr"
  ecr-repo-name           = var.ecr-repo-name
  ecr-repo-tag-mutability = var.ecr-repo-tag-mutability
}

module "s3" {
  source                      = "./modules/s3"
  s3-bucket-name              = var.s3-bucket-name
  s3-bucket-object-ownership  = var.s3-bucket-object-ownership
  s3-bucket-sse-algorithm     = var.s3-bucket-sse-algorithm
  s3-bucket-tag               = var.s3-bucket-tag
  s3-bucket-versioning-status = var.s3-bucket-versioning-status
}
