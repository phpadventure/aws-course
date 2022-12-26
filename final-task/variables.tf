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

variable "vpc_cidr_block" {
    description = "VPC cidr block"
    type = string
}

variable "sb_public_cidr_block_1" {
    description = "Public cidr block 1"
    type = string
}

variable "sb_public_cidr_block_2" {
    description = "Public cidr block 1"
    type = string
}

variable "sb_private_cidr_block_1" {
    description = "Private cidr block 1"
    type = string
}

variable "sb_private_cidr_block_2" {
    description = "Private cidr block 1"
    type = string
}

variable "az_public_1" {
    description = "Public az 1"
    type = string
}

variable "az_public_2" {
    description = "Public az 2"
    type = string
}

variable "az_private_1" {
    description = "Private az 1"
    type = string
}

variable "az_private_2" {
    description = "Private az 2"
    type = string
}