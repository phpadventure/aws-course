output "ec2_private_ip" {
    value = aws_instance.private-instance.private_ip
}

output "lb_url" {
    value = module.load-balancer.lb_endpoint
}

output "rds_endpoint" {
  value = module.persistance.rds_endpoint
}