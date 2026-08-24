variable "vpc_id" {
  description = "ID of the VPC where security groups will be created"
  type        = string
}

variable "project_name" {
  description = "Project name used for naming resources"
  type        = string
}

variable "app_port" {
  description = "Port used by the application running on EC2"
  type        = number
  default     = 8080
}