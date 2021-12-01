
// define an s3 backend here
terraform {
  backend "s3" {
    bucket         = "eliran-cloudschool"
    key            = "terraform-workshop/terraform.tfstate"
    dynamodb_table = "tf-workshop-site-locks"
    region         = "eu-west-1"
  }
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"
}

provider "aws" {
  profile = "default"
  region  = "eu-west-1"
}

module "vpc" {
  source = "../"

  environment     = "workshop-production"
  region          = "eu-west-1"
  vpc_cidr =  "172.18.0.0/18"
  private_subnets = "172.18.0.0/20,172.18.16.0/20"  
  public_subnets  =   "172.18.32.0/20,172.18.48.0/20"
  azs = "eu-west-1a,eu-west-1b"

  enable_dns_support   = true
  enable_dns_hostnames = true

}
