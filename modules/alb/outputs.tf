output "target_group_arn" {
  value = aws_lb_target_group.app.arn
}

output "alb_dns_name" {
  value = aws_lb.app.dns_name
}

output "alb_zone_id" {
  value = aws_lb.app.zone_id
}

# ALB ARN Suffix
output "alb_arn_suffix" {
  value = aws_lb.app.arn_suffix
}

# Target Group ARN Suffix
output "target_group_arn_suffix" {
  value = aws_lb_target_group.app.arn_suffix
}