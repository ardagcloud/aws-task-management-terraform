variable "project_name" {
  type        = string
  description = "Project name"
}

variable "private_app_subnet_ids" {
  type        = list(string)
  description = "Private subnet IDs for EC2 instances"
}

variable "ec2_sg_id" {
  type        = string
  description = "Security group ID for EC2 instances"
}

variable "target_group_arn" {
  type        = string
  description = "ALB target group ARN"
}

variable "instance_type" {
  type        = string
  description = "EC2 instance type"
  default     = "t3.micro"
}