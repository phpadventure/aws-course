variable "dynamodb_table_name" {
    description = "DynamoDB table name"
    type = string
}

variable "dynamodb_field_name" {
    description = "DynamoDB field name"
    type = string
}

variable "db_user" {
    description = "RDS user"
    type = string
}

variable "db_pw" {
    description = "RDS pw"
    type = string
}

variable "rds_group_ids" {
    description = "Subnet group ids"
    type = list(string)
}

variable "cidr_block" {
    description = "Cidr block list"
    type = list(string)
}

variable "vpc_id" {
    description = "VPC ID"
    type = string
}
