// ??? whole file
variable "instance_type" {
  description = "instance type for workshop-app instances"
  default = "t2.micro"
}

variable "ami" {
  description = "ami id for workshop-app instances"
  default = "ami-0a8e758f5e873d1c1"
}

variable "role" {
	default = "workshop-app-wrapper"
}

variable "cluster_name" {
	default = "workshop-terraform"
}

variable "workshop-app_cluster_size_min" {  
  default = 1
}

variable "workshop-app_cluster_size_max" {
  default = 5
}

variable "additional_sgs" {
  default = ""
}

variable "terraform_bucket" {
  default = "eliran-cloudschool"
  description = <<EOS
S3 bucket with the remote state of the site module.
The site module is a required dependency of this module
EOS

}

variable "site_module_state_path" {
  default = "terraform-workshop/terraform.tfstate"
  description = <<EOS
S3 path to the remote state of the site module.
The site module is a required dependency of this module
EOS

}

variable web-app {
  default = "apache2"
} 

variable region {
  default = "eu-west-1"  
} 

variable "main-instance_vault_sg_id" {
  description = "Main-instance vault security group id"
}

variable "main-instance_consul_sg_id" {
  description = "Main-instance consul security group id"
}

variable "rds-mysql-db_sg_id" {
    description = "RDS MySQL security group id"
}

variable "main-instance_local_ipv4" {
  description = "Main instance local ipv4"
  
}