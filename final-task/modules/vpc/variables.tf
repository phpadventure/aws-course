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
