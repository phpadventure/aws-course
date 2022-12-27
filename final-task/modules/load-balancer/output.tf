output "lb_endpoint" {
    value = aws_lb.lb-week4.dns_name
}

output "target_group_arn" {
  value = aws_lb_target_group.lb-target-group-week4.arn
}