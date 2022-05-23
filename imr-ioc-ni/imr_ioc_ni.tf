
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
    "gov-dev" : "404234"
    "gov-stage" : "40234"
    "gov-prod" : "403234234"
    "gov-sandbox" : "26323423"
  }
}

provider "aws" {
  region = "us-gov-west-1"
  assume_role {
    role_arn     = "arn:aws-us-gov:iam::${var.role_partition_ids["gov-stage"]}:role/CVLE_Administrator"
    session_name = "terraform"
  }
}

locals {
  environment = "stage"

  subnet_1  = tolist(data.aws_subnet_ids.vpc_range_subs_private_ids.ids)[0]
  subnet_2  = tolist(data.aws_subnet_ids.vpc_range_subs_private_ids.ids)[1]
  eni_count = 4 # This sets the number of how many ENIs that are created
}

data "aws_vpc" "vpc_range" {
  filter {
    name = "tag:Name"
    values = [
    "RANGE-VPC"]
  }
}
data "aws_subnet_ids" "vpc_range_subs_private_ids" {
  vpc_id = data.aws_vpc.vpc_range.id
  tags = {
    Tier = "RANGE-Private"
  }
}

data "aws_subnet" "vpc_range_subs_private" {
  for_each = data.aws_subnet_ids.vpc_range_subs_private_ids.ids
  id       = each.value
}

output "vpc_range_subs_private_cidr_blocks" {
  value       = [for s in data.aws_subnet.vpc_range_subs_private : s.cidr_block]
  description = "The CIDR block associated with the Private Subnets"
}

output "vpc_range_subs_private_ids" {
  value       = [for s in data.aws_subnet.vpc_range_subs_private : s.id]
  description = "The subnet ids associated with the Private Subnets"
}


resource "aws_security_group" "range-imr-ioc-ni-sg" {
  vpc_id = data.aws_vpc.vpc_range.id
  name   = "RANGE-IMR-IOC-NI-SG"

  ingress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = [
      "0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = [
      "0.0.0.0/0"]
  }

  tags = {
    "Name"        = "RANGE-IMR-IOC-NI-SG"
    "Environment" = local.environment
  }
}




resource "aws_network_interface" "ni_1" {
  count     = local.eni_count
  subnet_id = local.subnet_1
  security_groups = [aws_security_group.range-imr-ioc-ni-sg.id]

  tags = {
    "Name"        = "ec2-ioc-ni-1-${count.index + 1}"
    "Environment" = local.environment
    "Kind"        = "ec2-imr-ioc-ni_1"
  }
}

data "aws_network_interface" "ni_1" {
  count = local.eni_count
  id    = aws_network_interface.ni_1[count.index].id
}

output "eni_1_ids" {
  value = [for s in data.aws_network_interface.ni_1 : s.id]
}

output "eni_1_ips" {
  value = [for s in data.aws_network_interface.ni_1 : s.private_ip]
}

// Turn off the second ENI for now.
// This will be used for when provisioning resources that exceed 255 ec2 resources.
//resource "aws_network_interface" "ani_2" {
//  count     = local.ani_count
//  subnet_id = local.subnet_2
//  tags = {
//    "Name"        = "ec2-ioc-ni-2-${count.index + 1}"
//    "Environment" = local.environment
//    "Kind"        = "ec2-imr-ioc-ni_2"
//  }
//}
//
//data "aws_network_interface" "ani_2" {
//  count = local.ani_count
//  id    = aws_network_interface.ani_2[count.index].id
//}
//
//output "ani_2_ids" {
//  value = [for s in data.aws_network_interface.ani_2 : s.id]
//}
//
//output "ani_2_ips" {
//  value = [for s in data.aws_network_interface.ani_2 : s.private_ip]
//}
