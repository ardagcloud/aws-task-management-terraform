# RDS Endpoint
output "db_endpoint" {
  value = aws_db_instance.main.endpoint
}

# RDS Port
output "db_port" {
  value = aws_db_instance.main.port
}

# RDS Secret ARN
output "master_user_secret_arn" {
  value = aws_db_instance.main.master_user_secret[0].secret_arn
}

# RDS Instance ID
output "rds_instance_id" {
  value = aws_db_instance.main.identifier
}