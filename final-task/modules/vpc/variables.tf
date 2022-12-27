variable "nat_instance_id" {
    description = "NAT instance Id from AWS repo"
    type = string
    default = "ami-0f95da1ca59f7dea0"
}

variable "instance_type" {
    description = "Instance type"
    type = string
    default = "t2.micro"
}

variable "instance_ssh_key" {
    description = "Instance type"
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