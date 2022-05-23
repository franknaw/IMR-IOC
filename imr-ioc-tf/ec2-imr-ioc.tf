
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.54"
    }
  }
}

variable "role_partition_ids" {
  type = map(string)
  default = {
    "gov-dev" : "40ertert57"
    "gov-stage" : "404345565690636"
    "gov-prod" : "40345645643"
    "gov-sandbox" : "26234232116"
  }
}

provider "aws" {
  region = "us-gov-west-1"
  assume_role {
    role_arn     = "arn:aws-us-gov:iam::${var.role_partition_ids["gov-dev"]}:role/CVLE_Administrator"
    session_name = "terraform"
  }
}


data "aws_vpc" "vpc_range" {
  filter {
    name = "tag:Name"
    values = [
    "RANGE-VPC"]
  }
}

locals {
  environment       = "sandbox"
  ami_dc            = "ami-0b8sdfsdfsd418f"  #IOC_DC_base
  ami_wks           = "ami-0c3sdfsd39f85e3f" #IOC_Wks_base
  instance_type     = "t3.large"
  instance_type_wks = "t2.large"
}


// Generated TF Below #########################3



//--------------------------------------------------------------//

resource "aws_security_group" "ec2-ioc-sg-1" {
  vpc_id = data.aws_vpc.vpc_range.id
  name   = "RANGE_IOC-SG-1"

  ingress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = [
    "172.16.16.31/32", "172.16.16.144/32", "172.16.32.150/32", "172.16.33.254/32"]
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = [
    "172.16.16.31/32", "172.16.16.144/32", "172.16.32.150/32", "172.16.33.254/32"]
  }

  tags = {
    "Name"        = "RANGE_IOC-SG-1"
    "Environment" = local.environment
    "Kind"        = "RANGE_IOC-SG"
  }
}


resource "aws_instance" "ec2-ioc-dc-1" {
  ami           = local.ami_dc
  instance_type = local.instance_type

  tags = {
    "Name"        = "IOC-DC-1"
    "Environment" = local.environment
    "Kind"        = "IOC-DC"
  }

  network_interface {
    network_interface_id = "eni-0d07werwer537a0"
    device_index         = 0
  }
}

resource "aws_network_interface_sg_attachment" "dc_sg_attachment-1" {
  security_group_id    = aws_security_group.ec2-ioc-sg-1.id
  network_interface_id = "eni-0d07werwer37a0"
}


resource "aws_instance" "ec2-ioc-wks-1" {
  ami           = local.ami_wks
  instance_type = local.instance_type_wks

  tags = {
    "Name"        = "IOC-WKS-1"
    "Environment" = local.environment
    "Kind"        = "IOC-WKS"
  }

  network_interface {
    network_interface_id = "eni-0f47a7werwe7eb7"
    device_index         = 0
  }
}

resource "aws_network_interface_sg_attachment" "wks_sg_attachment-1" {
  security_group_id    = aws_security_group.ec2-ioc-sg-1.id
  network_interface_id = "eni-0f4wer7eb7"
}

//--------------------------------------------------------------//




//--------------------------------------------------------------//

resource "aws_security_group" "ec2-ioc-sg-2" {
  vpc_id = data.aws_vpc.vpc_range.id
  name   = "RANGE_IOC-SG-2"

  ingress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = [
    "172.16.16.167/32", "172.16.16.197/32", "172.16.32.150/32", "172.16.33.254/32"]
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = [
    "172.16.16.167/32", "172.16.16.197/32", "172.16.32.150/32", "172.16.33.254/32"]
  }

  tags = {
    "Name"        = "RANGE_IOC-SG-2"
    "Environment" = local.environment
    "Kind"        = "RANGE_IOC-SG"
  }
}


resource "aws_instance" "ec2-ioc-dc-2" {
  ami           = local.ami_dc
  instance_type = local.instance_type

  tags = {
    "Name"        = "IOC-DC-2"
    "Environment" = local.environment
    "Kind"        = "IOC-DC"
  }

  network_interface {
    network_interface_id = "eni-054e0werwer8d"
    device_index         = 0
  }
}

resource "aws_network_interface_sg_attachment" "dc_sg_attachment-2" {
  security_group_id    = aws_security_group.ec2-ioc-sg-2.id
  network_interface_id = "eni-054e0dwerwe878d"
}


resource "aws_instance" "ec2-ioc-wks-2" {
  ami           = local.ami_wks
  instance_type = local.instance_type_wks

  tags = {
    "Name"        = "IOC-WKS-2"
    "Environment" = local.environment
    "Kind"        = "IOC-WKS"
  }

  network_interface {
    network_interface_id = "eni-078wer22108"
    device_index         = 0
  }
}

resource "aws_network_interface_sg_attachment" "wks_sg_attachment-2" {
  security_group_id    = aws_security_group.ec2-ioc-sg-2.id
  network_interface_id = "eni-078ewer22108"
}

//--------------------------------------------------------------//



