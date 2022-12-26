output "rds_endpoint" {
    value = aws_db_instance.postgresql_rds_test.address
}

output "rds_port" {
    value = aws_db_instance.postgresql_rds_test.port
}