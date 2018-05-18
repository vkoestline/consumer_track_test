# --------------------------------------
# Get all AZs
# --------------------------------------
data "aws_availability_zones" "available" {}

# --------------------------------------
# Loading VPC and Install module
# --------------------------------------
module "networking" {
  source = "terraform-aws-modules/vpc/aws"

  name = "nginx-network"
  cidr = "${var.vpc_cidr}"

  azs             = "${data.aws_availability_zones.available.names}"
  private_subnets = "${var.private_subnets}"
  public_subnets  = "${var.public_subnets}"

  public_subnet_tags = {Tier = "Public"}
  private_subnet_tags = {Tier = "Private"}

  enable_nat_gateway = true
  enable_dns_support = true
  enable_dns_hostnames = true

}

