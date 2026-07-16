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

  interface_endpoints = {
    ec2 = "com.amazonaws.eu-west-2.ec2"
    ecr-api = "com.amazonaws.eu-west-2.ecr.api"
    ecr-dkr = "com.amazonaws.eu-west-2.ecr.dkr"
    elb = "com.amazonaws.eu-west-2.elasticloadbalancing"
    eks = "com.amazonaws.eu-west-2.eks"
    eks-auth = "com.amazonaws.eu-west-2.eks-auth"
    route53 = "com.amazonaws.route53"
    logs = "com.amazonaws.eu-west-2.logs"
    kms = "com.amazonaws.eu-west-2.kms"
    secretsmanager = "com.amazonaws.eu-west-2.secretsmanager"
  }
}
