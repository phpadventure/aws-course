resource "aws_security_group" "https-ssh-security-group" {
    description = "Enable HTTP access via port 80 + SSH access for ${var.sg_name}"
    name = "sg_${var.sg_name}"
    vpc_id = var.vpc_id

    ingress {
        description      = "HTTP from VPC"
        from_port        = 80
        to_port          = 80
        protocol         = "tcp"
        cidr_blocks      = var.cidr_block
    }
    ingress {
        description      = "SSH from VPC"
        from_port        = 22
        to_port          = 22
        protocol         = "tcp"
        cidr_blocks      = var.cidr_block
    }
    ingress {
        description      = "HTTPS from VPC"
        from_port        = 443
        to_port          = 443
        protocol         = "tcp"
        cidr_blocks      = var.cidr_block
    }

    egress {
        from_port        = 0
        to_port          = 0
        protocol         = "-1"
        cidr_blocks      = ["0.0.0.0/0"]
        ipv6_cidr_blocks = ["::/0"]
    }
}