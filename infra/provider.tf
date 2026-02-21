terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.33.0"
    }
  }

  backend "s3" {
    bucket       = "eks-bootstrap-bucket-for-terraform-state"
    key          = "terraform.tfstate"
    use_lockfile = true
    region       = "eu-west-2"
    encrypt      = true
  }
}

provider "aws" {
  region = "eu-west-2"
}
