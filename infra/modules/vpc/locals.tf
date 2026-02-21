locals {

  public_subnets = {

    sub1 = {
      cidr_block        = var.public-sub1-cidr
      availability_zone = var.az1
      tags = {
        Name = var.public-sub1-tags
      }
    }

    sub2 = {
      cidr_block        = var.public-sub2-cidr
      availability_zone = var.az2
      tags = {
        Name = var.public-sub2-tags
      }
    }

    sub3 = {
      cidr_block        = var.public-sub3-cidr
      availability_zone = var.az3
      tags = {
        Name = var.public-sub3-tags
      }
    }
  }

  private_subnets = {

    sub1 = {
      cidr_block        = var.private-sub1-cidr
      availability_zone = var.az1
      tags = {
        Name = var.private-sub1-tags
      }
    }

    sub2 = {
      cidr_block        = var.private-sub2-cidr
      availability_zone = var.az2
      tags = {
        Name = var.private-sub2-tags
      }
    }

    sub3 = {
      cidr_block        = var.private-sub3-cidr
      availability_zone = var.az3
      tags = {
        Name = var.private-sub3-tags
      }
    }
  }
}
