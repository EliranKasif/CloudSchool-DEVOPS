// ??? whole file
variable "multi_az" {
  default = false
}

variable "apply_immediately" {
  default = true
}

variable "identifier" {
  default = "workshop-app-db"
}

variable "publicly_accessible" {
  default = "true"
}

variable "engine" {
  default = "mysql"
}

variable "engine_version" {
  default = "5.7.26"
}

variable "instance_class" {
  default = "db.t2.micro"
}

variable "name" {
  default = "workshopDB"
}

variable "storage_type" {
  default = "standard"
}

variable "allocated_storage" {
  default = "20"
}
variable "availability_zone" {
  default = "eu-west-1a"
}

variable "skip_final_snapshot" {
  default = true
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

variable "region" {
  default = "eu-west-1"  
}