terraform {
  backend "s3" {
    bucket         = "eliran-cloudschool"
    key            = "terraform-workshop-env/terraform.tfstate"
    dynamodb_table = "tf-workshop-site-locks"
    region         = "eu-west-1"
  }
}

provider "aws" {
  region = "eu-west-1"
}


module "workshop-app" {
  source = "../workshop-app"
}

module "rds-global" {
  source = "../rds-global"
}
