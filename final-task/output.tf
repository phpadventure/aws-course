output "ec2_private_ip" {
    value = aws_instance.private-instance.private_ip
}

output "lb_url" {
    value = module.load-balancer.lb_endpoint
}