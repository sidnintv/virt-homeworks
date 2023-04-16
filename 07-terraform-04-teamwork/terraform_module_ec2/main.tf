provider "aws" {
  region = "us-east-1"
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

module "vmubuntu" {
  source = "terraform-aws-modules/ec2-instance/aws"
  
  name           = "vmubuntu-instance"
  
  ami            = data.aws_ami.ubuntu.id
  instance_type  = "t2.micro"

  key_name               = "stv"
  associate_public_ip_address = true
  monitoring            = true
  disable_api_termination = false
  instance_initiated_shutdown_behavior = "stop"

  vpc_security_group_ids = ["sg-05f3f7b4af3361e8d"]
  subnet_id              = "subnet-0dcdedcf7497aadb8"
}

data "aws_caller_identity" "current" {}
data "aws_region" "current" {}
