variable "sg_name" {
    description = "Security group name"
    type = string
}

variable "vpc_id" {
    description = "VPIC id"
    type = string
}

variable "cidr_block" {
    description = "Instance type"
    type    = list(string)
}
