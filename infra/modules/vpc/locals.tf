locals {

  public_subnets = {

    sub1 = {
      cidr_block        = "10.0.0.0/19"
      availability_zone = "eu-west-2a"
      tags = {
        Name = "public-sub1"
      }
    }

    sub2 = {
      cidr_block        = "10.0.32.0/19"
      availability_zone = "eu-west-2b"
      tags = {
        Name = "public-sub2"
      }
    }

    sub3 = {
      cidr_block        = "10.0.64.0/19"
      availability_zone = "eu-west-2c"
      tags = {
        Name = "public-sub3"
      }
    }
  }

  private_subnets = {

    sub1 = {
      cidr_block        = "10.0.96.0/19"
      availability_zone = "eu-west-2a"
      tags = {
        Name = "private-sub1"
      }
    }

    sub2 = {
      cidr_block        = "10.0.128.0/19"
      availability_zone = "eu-west-2b"
      tags = {
        Name = "private-sub2"
      }
    }

    sub3 = {
      cidr_block        = "10.0.160.0/19"
      availability_zone = "eu-west-2c"
      tags = {
        Name = "private-sub3"
      }
    }
  }
}
