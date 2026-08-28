# Project Name
variable "project_name" {
  type        = string
  description = "Project name"
}

# Auto Scaling Group Name
variable "asg_name" {
  type        = string
  description = "Auto Scaling Group name"
}

# RDS Instance ID
variable "rds_instance_id" {
  type        = string
  description = "RDS database instance identifier"
}

# ALB ARN Suffix
variable "alb_arn_suffix" {
  type        = string
  description = "ALB ARN suffix"
}

# Target Group ARN Suffix
variable "target_group_arn_suffix" {
  type        = string
  description = "ALB target group ARN suffix"
}