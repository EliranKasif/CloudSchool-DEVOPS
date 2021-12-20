variable "cluster_name" {
	default = "jenkins-server"
}

variable "main-instance_local_ipv4" {
  description = "Main instance local ipv4"
  
}
variable "main-instance_ssh_sg_id" {
  description = "Main-instance ssh security group id"
}

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

variable region {
  default = "eu-west-1"  
} 

variable "iam_cloudwatch_s3_profile_id" {
  description = "iam role id for cloudwatch and s3 full access"
  
}

variable "iam_cloudwatch_s3_profile_name" {
  description = "iam role name for cloudwatch and s3 full access"
  
}

