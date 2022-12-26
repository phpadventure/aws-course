variable "instance_ssh_key" {
    description = "Instance type"
    type = string
}

variable "public_init_sh_file" {
    description = "User data file path"
    type = string
}

variable "private_init_sh_file" {
    description = "User data file path"
    type = string
}

variable "dynamodb_table_name" {
    description = "DynamoDB table name"
    type = string
}

variable "dynamodb_field_name" {
    description = "DynamoDB field name"
    type = string
}

variable "db_user" {
    description = "DynamoDB field name"
    type = string
}

variable "db_pw" {
    description = "DynamoDB field name"
    type = string
}