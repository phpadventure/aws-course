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