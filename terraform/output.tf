output "load_balancer_url" {
  value = aws_lb.main-elb.dns_name
}
