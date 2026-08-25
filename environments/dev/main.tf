# VPC Module
module "vpc" {
  source = "../../modules/vpc"

  project_name = var.project_name
  vpc_cidr     = var.vpc_cidr
}

# Security Module
module "security" {
  source = "../../modules/security"

  vpc_id       = module.vpc.vpc_id
  project_name = var.project_name
}

# ALB Module
module "alb" {
  source = "../../modules/alb"

  vpc_id            = module.vpc.vpc_id
  public_subnet_ids = module.vpc.public_subnet_ids
  alb_sg_id         = module.security.alb_sg_id
  project_name      = var.project_name
}


# Compute Module
module "compute" {
  source = "../../modules/compute"

  project_name           = var.project_name
  private_app_subnet_ids = module.vpc.private_app_subnet_ids
  ec2_sg_id              = module.security.ec2_sg_id
  target_group_arn       = module.alb.target_group_arn
}