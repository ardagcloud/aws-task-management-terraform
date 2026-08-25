# Auto Scaling Group Name
output "asg_name" {
  value = aws_autoscaling_group.app.name
}

# Launch Template ID
output "launch_template_id" {
  value = aws_launch_template.app.id
}