variable "environment" {
  default = "staging"
}

variable "key_name" {
  description = "The aws keypair to use"
}

variable "region" {
  description = "Region that the instances will be created"
}

variable "primary_availability_zone" {
  description = "The AZ that the resources will be launched"
}

variable "secondary_availability_zone" {
  description = "The AZ that the resources will be launched"
}

# Networking

variable "vpc_cidr" {
  description = "The CIDR block of the VPC"
}

variable "public_subnet_cidr" {
  description = "The CIDR block of the public subnet"
}

variable "public_subnet_cidr_2" {
  description = "The CIDR block of the public subnet"
}

variable "private_subnet_cidr" {
  description = "The CIDR block of the private subnet"
}

variable "app_name" {
  default = "backend_api_app"
}

variable "web_instance_count" {
  description = "The total of web instances to run"
  default     = 1
}

# rds module variables
variable "db_identifier" {
  description = "Database Name (Identifier)"
}

variable "db_instance_class" {
  description = "Database Instance Class"
}

variable "db_username" {
  description = "Database Username"
}

variable "db_password" {
  description = "Database Password"
}

variable "allocated_storage" {
  description = "The allocated storage in gigabytes"
}

variable "backup_window" {
  description = "The daily time range (in UTC) during which automated backups are created"
  default     = "03:00-06:00"
}

variable "maintenance_window" {
  description = "Maintenance Window"
  default     = "Mon:00:00-Mon:03:00"
}
