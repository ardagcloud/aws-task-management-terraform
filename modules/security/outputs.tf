# ALB Security Group ID
output "alb_sg_id" {
  value = aws_security_group.alb.id
}

# EC2 Security Group ID
output "ec2_sg_id" {
  value = aws_security_group.ec2.id
}

# RDS Security Group ID
output "rds_sg_id" {
  value = aws_security_group.rds.id
}