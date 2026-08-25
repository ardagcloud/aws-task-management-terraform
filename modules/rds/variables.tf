variable "project_name" {
  type        = string
  description = "Project name"
}

variable "private_db_subnet_ids" {
  type        = list(string)
  description = "Private database subnet IDs"
}

variable "rds_sg_id" {
  type        = string
  description = "Security group ID for RDS"
}

variable "db_name" {
  type        = string
  description = "Database name"
  default     = "taskmanagement"
}

variable "db_username" {
  type        = string
  description = "Database username"
  default     = "dbadmin"
}