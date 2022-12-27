variable "vpc_id" {
    description = "VPIC id"
    type = string
}

variable "subnet_ids" {
    description = "Subnet ids"
    type    = list(string)
}

variable "health_check_path" {
    description = "Health check path"
    type = string
}