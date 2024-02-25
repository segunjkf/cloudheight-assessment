output "load_balancer_url" {
  value = aws_lb.main_elb.dns_name
}
