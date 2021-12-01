
data "terraform_remote_state" "site" {
  backend = "s3"
  config = {
    bucket = var.terraform_bucket
    key = var.site_module_state_path
    region = var.region
  }
}

resource "aws_instance" "main-server_lc" {
  user_data =   templatefile("${path.module}/templates/main-instance.cloudinit", {database_url_terraform = var.database_url, database_username_terraform = var.database_user, database_password_terraform = var.database_password })
  security_groups = [aws_security_group.main-instance_vault.id, aws_security_group.main-instance_consul.id, var.rds-mysql-db_sg_id, aws_security_group.main-instance-ssh.id ]
  subnet_id = element(element(data.terraform_remote_state.site.outputs.public_subnets, 0), 0)
  count = 1
  ami = var.ami
  instance_type = var.instance_type
  key_name = data.terraform_remote_state.site.outputs.admin_key_name
  tags  ={
    Name = "Main-server"
    Source = "Terraform"
  }
}

resource "aws_security_group" "main-instance_vault" {
  lifecycle {  
    create_before_destroy = true
  }

  name = "${var.cluster_name}_services_vault"
  description = "sg for ${var.cluster_name} vault service"
  vpc_id = data.terraform_remote_state.site.outputs.vpc_id
  ingress {
    description      = "vault"
    from_port        = 8200
    to_port          = 8200
    protocol         = "tcp"
    self = true
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
resource "aws_security_group" "main-instance_consul" {
  lifecycle {  
    create_before_destroy = true
  }

  name = "${var.cluster_name}_services_consul"
  description = "sg for ${var.cluster_name} consul service"
  vpc_id = data.terraform_remote_state.site.outputs.vpc_id
  ingress {
    description      = "consul"
    from_port        = 8500
    to_port          = 8500
    protocol         = "tcp"
    self = true
  }
    ingress {
    description      = "consul"
    from_port        = 8600
    to_port          = 8600
    protocol         = "tcp"
    self = true
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "main-instance-ssh" {
    lifecycle {  
    create_before_destroy = true
  }

  name = "${var.cluster_name}_ssh"
  description = "sg for ${var.cluster_name} ssh service"
  vpc_id = data.terraform_remote_state.site.outputs.vpc_id
  ingress {
    description      = "ssh"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}