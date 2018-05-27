module "networking" {
  source                      = "../modules/networking"
  environment                 = "${var.environment}"
  vpc_cidr                    = "${var.vpc_cidr}"
  public_subnet_cidr          = "${var.public_subnet_cidr}"
  private_subnet_cidr         = "${var.private_subnet_cidr}"
  region                      = "${var.region}"
  primary_availability_zone   = "${var.primary_availability_zone}"
  secondary_availability_zone = "${var.secondary_availability_zone}"
  key_name                    = "${var.key_name}"
  app_name                    = "${var.app_name}"
  public_subnet_cidr_2        = "${var.public_subnet_cidr_2}"
}
