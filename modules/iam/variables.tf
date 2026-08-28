# Project Name
variable "project_name" {
  type        = string
  description = "Project name"
}

# RDS Master Secret ARN
variable "rds_secret_arn" {
  type        = string
  description = "ARN of the RDS master credential secret"
}