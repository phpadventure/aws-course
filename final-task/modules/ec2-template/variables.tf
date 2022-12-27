variable "instance_id" {
    description = "Instance Id from AWS repo"
    type = string
    default = "ami-094125af156557ca2"
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

variable "vpc_security_group_id" {
    description = "Security group id"
    type = string
    default = ""
}

variable "template_name" {
    description = "Template name"
    type = string
}

variable "user_data" {
    description = "User data content"
    type = string
}

variable "iam_instance_profile_arn" {
    description = "Arn of profile with roles and access"
    type = string
}