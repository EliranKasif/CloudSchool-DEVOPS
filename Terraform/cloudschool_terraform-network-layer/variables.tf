variable "environment" {
  description = "This is mainly used to set various ideintifiers and prefixes/suffixes"
  default = "workshop-production"
}

variable "private_subnets" {
  description = "IP prefix of private (vpc only routing) subnets"
  default = "172.18.0.0/20,172.18.16.0/20"

}

variable "public_subnets" {
  description = "IP prefix of public (internet gw route) subnet"
  default = "172.18.32.0/20,172.18.48.0/20"
}

variable "region" {
  type = string
  default = "eu-west-1"
}

variable "azs" {
  type        = string
  description = "azs"
  default = "eu-west-1a,eu-west-1b"
}

variable "enable_dns_hostnames" {
  description = "should be true if you want to use private DNS within the VPC"
  default     = true
}
variable "enable_dns_support" {
  description = "should be true if you want to use private DNS within the VPC"
  default     = true
}

variable "vpc_cidr" {
  type        = string
  description = "IP prefix of main vpc"
  default = "172.18.0.0/18"
}
