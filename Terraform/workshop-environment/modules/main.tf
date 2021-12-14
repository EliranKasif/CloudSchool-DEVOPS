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

module "rds-global" {
  source = "../rds-global"
}


module "main-server" {
  source = "../main-server"
  database_user = "${module.rds-global.database_user}"
  database_password = "${module.rds-global.database_password}"
  database_url = "${module.rds-global.database_url}"
  rds-mysql-db_sg_id = "${module.rds-global.rds-mysql-db_sg_id}"
  depends_on = [module.rds-global]
}

module "workshop-app" {
  source = "../workshop-app"
  main-instance_vault_sg_id = "${module.main-server.main-instance_vault_sg_id}"
  main-instance_consul_sg_id = "${module.main-server.main-instance_consul_sg_id}"
  rds-mysql-db_sg_id = "${module.rds-global.rds-mysql-db_sg_id}"
  main-instance_local_ipv4 = "${module.main-server.main-instance_local_ipv4}"
  iam_cloudwatch_s3_profile_id = "${module.main-server.cloudwatch_s3_profile_id}"
  iam_cloudwatch_s3_profile_name = "${module.main-server.cloudwatch_s3_profile_name}"
  depends_on = [module.rds-global, module.main-server]
}

module "jenkins-server" {
  source = "../jenkins-server"
  main-instance_ssh_sg_id = "${module.main-server.main-instance_ssh_sg_id}"
  main-instance_local_ipv4 = "${module.main-server.main-instance_local_ipv4}"
  depends_on = [module.main-server]
}




