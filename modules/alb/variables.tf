variable "vpc_id" {
  type        = string
  description = "VPC ID"
}

variable "public_subnet_ids" {
  type        = list(string)
  description = "Public subnet IDs for the ALB"
}

variable "alb_sg_id" {
  type        = string
  description = "Security group ID for the ALB"
}

variable "project_name" {
  type        = string
  description = "Project name"
}

variable "app_port" {
  type        = number
  description = "Application port for the target group"
  default     = 8080
}