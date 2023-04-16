terraform {
  backend "s3" {
    bucket = "sidninterrastatre"
    region = "us-east-1"
  }
}

provider "aws" {
  region = "us-east-1"
}

locals {
  workspace_instance_type = {
    stage = "t2.micro"
    prod  = "t2.small"
  }

  workspace_instance_count = {
    stage = 1
    prod  = 2
  }
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

resource "aws_instance" "vmubuntu" {
  count = local.workspace_instance_count[terraform.workspace]

  ami           = data.aws_ami.ubuntu.id
  instance_type = local.workspace_instance_type[terraform.workspace]

  key_name               = "stv"
  associate_public_ip_address = true
  monitoring            = true
  disable_api_termination = false
  instance_initiated_shutdown_behavior = "stop"

  vpc_security_group_ids = ["sg-05f3f7b4af3361e8d"]
  subnet_id              = "subnet-0dcdedcf7497aadb8"

  tags = {
    Name = "vmubuntu-instance"
  }
}

resource "aws_instance" "vmubuntu_foreach" {
  for_each = { for i in range(local.workspace_instance_count[terraform.workspace]) : i => i }

  ami           = data.aws_ami.ubuntu.id
  instance_type = local.workspace_instance_type[terraform.workspace]

    key_name               = "stv"
  associate_public_ip_address = true
  monitoring            = true
  disable_api_termination = false
  instance_initiated_shutdown_behavior = "stop"

  vpc_security_group_ids = ["sg-05f3f7b4af3361e8d"]
  subnet_id              = "subnet-0dcdedcf7497aadb8"

  tags = {
    Name = "vmubuntu-instance"
  }

  lifecycle {
    create_before_destroy = true
  }
}

data "aws_caller_identity" "current" {}
data "aws_region" "current" {}
