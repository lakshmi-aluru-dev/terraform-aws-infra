# Task 0: Provider-only configuration.
# No AWS resources are created in this task.
# ----------------------------
# env/dev - root module
# Task 5: Using reusable modules
# ----------------------------

data "aws_availability_zones" "available" {
  state = "available"
}

locals {
  vpc_cidr            = "10.0.0.0/16"
  public_subnet_cidr  = "10.0.1.0/24"
  private_subnet_cidr = "10.0.2.0/24"
  az                  = data.aws_availability_zones.available.names[0]
  name_prefix         = "tf-task2"
}

module "vpc" {
  source              = "../../modules/vpc"
  vpc_cidr            = local.vpc_cidr
  public_subnet_cidr  = local.public_subnet_cidr
  private_subnet_cidr = local.private_subnet_cidr
  availability_zone   = local.az
  name_prefix         = local.name_prefix
}
module "ebs" {
  source            = "../../modules/ebs"
  availability_zone = aws_instance.web.availability_zone
  instance_id       = aws_instance.web.id

  # keep defaults: size=10, type=gp3, encrypted=true, device_name=/dev/sdf, name=task4-data-ebs
}
