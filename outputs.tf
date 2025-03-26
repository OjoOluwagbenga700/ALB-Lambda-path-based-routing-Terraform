# Output value definitions

output "alb_url" {
  value = "http://${aws_lb.main.dns_name}"
}

