output "public_subnet_1_id" {
    value = aws_subnet.public-sb-1.id
}

output "public_subnet_2_id" {
   value = aws_subnet.public-sb-2.id
}

output "private_subnet_1_id" {
    value = aws_subnet.private-sb-1.id
}

output "private_subnet_2_id" {
    value = aws_subnet.private-sb-2.id
}

output "vpc_id" {
    value = aws_vpc.my-vpc.id
}