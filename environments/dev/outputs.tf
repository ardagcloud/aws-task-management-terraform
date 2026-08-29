# Application URL
output "application_url" {
  value = "http://${module.alb.alb_dns_name}"
}