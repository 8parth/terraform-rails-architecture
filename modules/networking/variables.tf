variable "vpc_cidr" {
  description = "The CIDR block of the VPC"
}

variable "public_subnet_cidr" {
  description = "The CIDR block for the public subnet"
}

variable "public_subnet_cidr_2" {
  description = "The CIDR block for the public subnet"
}

variable "private_subnet_cidr" {
  description = "The CIDR block for the private subnet"
}

variable "environment" {
  description = "The environment"
}

variable "region" {
  description = "The region to launch the bastion host"
}

variable "primary_availability_zone" {
  description = "The AZ that the resources will be launched"
}

variable "secondary_availability_zone" {
  description = "The AZ that the resources will be launched"
}

variable "bastion_ami" {
  default = {
    "us-east-1" = "ami-f652979b"
    "us-east-2" = "ami-fcc19b99"
    "us-west-1" = "ami-16efb076"
  }
}

variable "app_name" {
  description = "Name of Application"
}

variable "key_name" {
  description = "The public key for the bastion host"
}
