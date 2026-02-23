module "vpc" {
  source              = "./modules/vpc"
  vpc-cidr-block      = var.vpc-cidr-block
  vpc-tags            = var.vpc-tags
  private-rt-tags     = var.private-rt-tags
  private-sub1-cidr   = var.private-sub1-cidr
  private-sub1-tags   = var.private-sub1-tags
  private-sub2-cidr   = var.private-sub2-cidr
  private-sub2-tags   = var.private-sub2-tags
  private-sub3-cidr   = var.private-sub3-cidr
  private-sub3-tags   = var.private-sub3-tags
  public-rt-tags      = var.public-rt-tags
  public-sub1-cidr    = var.public-sub1-cidr
  public-sub1-tags    = var.public-sub1-tags
  public-sub2-cidr    = var.public-sub2-cidr
  public-sub2-tags    = var.public-sub2-tags
  public-sub3-cidr    = var.public-sub3-cidr
  public-sub3-tags    = var.public-sub3-tags
  igw-tags            = var.igw-tags
  internet-cidr       = var.internet-cidr
  nat-gw-connectivity = var.nat-gw-connectivity
  nat-gw-mode         = var.nat-gw-mode
  nat-gw-tags         = var.nat-gw-tags
  az1                 = var.az1
  az2                 = var.az2
  az3                 = var.az3
}

# module "eks" {
#   source = "value"
# }
