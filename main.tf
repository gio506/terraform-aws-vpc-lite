provider "aws" {
  region = var.aws_region
}

module "vpc_lite" {
  source = "./modules/vpc-lite"

  project_name        = var.project_name
  vpc_cidr            = var.vpc_cidr
  public_subnet_cidr  = var.public_subnet_cidr
  public_subnet_az    = var.public_subnet_az
  ssh_ingress_cidrs   = var.ssh_ingress_cidrs
  http_ingress_cidrs  = var.http_ingress_cidrs
  common_tags         = var.common_tags
}
