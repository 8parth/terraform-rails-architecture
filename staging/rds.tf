data "aws_vpc" "default" {
  id = "${module.networking.vpc_id}"
}

data "aws_subnet_ids" "all" {
  vpc_id = "${module.networking.vpc_id}"
}

data "aws_security_group" "default" {
  vpc_id = "${module.networking.vpc_id}"
  name   = "default"
}

module "rds" {
  source  = "terraform-aws-modules/rds/aws"
  version = "1.18.0"

  # insert the 10 required variables here
  allocated_storage          = "${var.allocated_storage}"
  engine                     = "postgres"
  engine_version             = "9.6.2"
  identifier                 = "${var.db_identifier}"
  instance_class             = "${var.db_instance_class}"
  username                   = "${var.db_username}"
  password                   = "${var.db_password}"
  auto_minor_version_upgrade = true
  availability_zone          = "${var.secondary_availability_zone}"
  port                       = 3542
  maintenance_window         = "${var.maintenance_window}"
  backup_window              = "${var.backup_window}"
  storage_encrypted          = false
  subnet_ids                 = ["${data.aws_subnet_ids.all.ids}"]
  major_engine_version       = 9.6
  family                     = "postgres9.6"
  vpc_security_group_ids     = ["${data.aws_security_group.default.id}"]

  tags {
    Environment = "${var.environment}"
    App         = "${var.app_name}"
    Name        = "rds-instance"
  }
}
