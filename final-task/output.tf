output "ec2_private_ip" {
    value = aws_instance.private-instance.private_ip
}