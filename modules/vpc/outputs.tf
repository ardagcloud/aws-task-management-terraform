#VPC ID
output "vpc_id" {
  value = aws_vpc.main.id
}

#VPC CIDR
output "vpc_cidr" {
  value = aws_vpc.main.cidr_block
}

# Public Subnet IDs
output "public_subnet_ids" {
  value = [
    aws_subnet.public_a.id,
    aws_subnet.public_b.id
  ]
}

# Private App Subnet IDs
output "private_app_subnet_ids" {
  value = [
    aws_subnet.private_app_a.id,
    aws_subnet.private_app_b.id
  ]
}

# Private DB Subnet IDs
output "private_db_subnet_ids" {
  value = [
    aws_subnet.private_db_a.id,
    aws_subnet.private_db_b.id
  ]
}