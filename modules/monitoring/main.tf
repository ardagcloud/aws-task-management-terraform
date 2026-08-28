# RDS High CPU Alarm
resource "aws_cloudwatch_metric_alarm" "rds_high_cpu" {
  alarm_name          = "${var.project_name}-rds-high-cpu"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/RDS"
  period              = 300
  statistic           = "Average"
  threshold           = 80
  alarm_description   = "Triggers when RDS CPU utilization is above 80 percent"

  dimensions = {
    DBInstanceIdentifier = var.rds_instance_id
  }
}

# ASG Instance Health Alarm
resource "aws_cloudwatch_metric_alarm" "asg_instance_health" {
  alarm_name          = "${var.project_name}-asg-instance-health"
  comparison_operator = "LessThanThreshold"
  evaluation_periods  = 2
  metric_name         = "GroupInServiceInstances"
  namespace           = "AWS/AutoScaling"
  period              = 300
  statistic           = "Average"
  threshold           = 2
  alarm_description   = "Triggers when fewer than 2 EC2 instances are in service"

  dimensions = {
    AutoScalingGroupName = var.asg_name
  }
}


# ALB Unhealthy Targets Alarm
resource "aws_cloudwatch_metric_alarm" "alb_unhealthy_targets" {
  alarm_name          = "${var.project_name}-alb-unhealthy-targets"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "UnHealthyHostCount"
  namespace           = "AWS/ApplicationELB"
  period              = 300
  statistic           = "Average"
  threshold           = 0
  alarm_description   = "Triggers when the ALB has unhealthy targets"

  dimensions = {
    LoadBalancer = var.alb_arn_suffix
    TargetGroup  = var.target_group_arn_suffix
  }
}