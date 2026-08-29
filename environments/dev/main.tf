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
  instance_profile_name  = module.iam.instance_profile_name
  db_endpoint            = module.rds.db_endpoint
  rds_secret_arn         = module.rds.master_user_secret_arn
}


# RDS Module
module "rds" {
  source = "../../modules/rds"

  project_name          = var.project_name
  private_db_subnet_ids = module.vpc.private_db_subnet_ids
  rds_sg_id             = module.security.rds_sg_id
}

# IAM Module
module "iam" {
  source = "../../modules/iam"

  project_name   = var.project_name
  rds_secret_arn = module.rds.master_user_secret_arn
}

# Monitoring Module
module "monitoring" {
  source = "../../modules/monitoring"

  project_name            = var.project_name
  asg_name                = module.compute.asg_name
  rds_instance_id         = module.rds.rds_instance_id
  alb_arn_suffix          = module.alb.alb_arn_suffix
  target_group_arn_suffix = module.alb.target_group_arn_suffix
}