provider "aws" {
    region = "us-west-2"
    profile = "default"
}

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

variable "db_pw" {
    description = "DB  password"
    type = string
}

resource "aws_security_group" "my_group_ssh_http" {
    description = "Enable HTTP access via port 80 + SSH access"
    name = "security_group_ssh_http"

    ingress {
        description      = "HTTP from VPC"
        from_port        = 80
        to_port          = 80
        protocol         = "tcp"
        cidr_blocks      = ["0.0.0.0/0"]
    }
    ingress {
        description      = "SSH from VPC"
        from_port        = 22
        to_port          = 22
        protocol         = "tcp"
        cidr_blocks      = ["0.0.0.0/0"]
    }

    egress {
        from_port        = 0
        to_port          = 0
        protocol         = "-1"
        cidr_blocks      = ["0.0.0.0/0"]
        ipv6_cidr_blocks = ["::/0"]
    }
}

resource "aws_security_group" "my_security_group_rds" {
    description = "Enable Postgres access"
    name = "my_security_group_rds"

    ingress {
        description      = "Postgresql"
        from_port        = 5432
        to_port          = 5432
        protocol         = "tcp"
        cidr_blocks      = ["0.0.0.0/0"]
    }

    egress {
        from_port        = 0
        to_port          = 0
        protocol         = "-1"
        cidr_blocks      = ["0.0.0.0/0"]
        ipv6_cidr_blocks = ["::/0"]
    }
}

resource "aws_instance" "my-instance" {
    key_name = var.instance_ssh_key
    ami = var.instance_id
    instance_type = var.instance_type
    security_groups = [aws_security_group.my_group_ssh_http.name]
    iam_instance_profile = aws_iam_instance_profile.ec2-access-profile.name
    user_data = "${file("download-from-s3-to-ec2.sh")}"
}

resource "aws_iam_instance_profile" "ec2-access-profile" {
  name = "ec2-access-profile"
  role = aws_iam_role.ec2-access-role.name
  path = "/"
}

resource "aws_iam_role" "ec2-access-role" {
    name = "ec2-access-role"
    managed_policy_arns = ["arn:aws:iam::aws:policy/AmazonS3FullAccess", "arn:aws:iam::aws:policy/AmazonDynamoDBFullAccess"]
    assume_role_policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
        {
            Action = "sts:AssumeRole"
            Effect = "Allow"
            Sid    = ""
            Principal = {
            Service = "ec2.amazonaws.com"
            }
        },
        ]
    })
}

resource "aws_dynamodb_table" "myDummyCollection-table" {
    name = "myDummyCollection"
    billing_mode   = "PROVISIONED"
    read_capacity  = 20
    write_capacity = 20
    hash_key       = "partKey"

    attribute {
        name = "partKey"
        type = "S"
    }
}

resource "aws_db_instance" "postgresql_rds_test" {
  allocated_storage    = 10
  engine               = "postgres"
  instance_class       = "db.t3.micro"
  username             = "root"
  password             = var.db_pw
  skip_final_snapshot  = true
  vpc_security_group_ids = [aws_security_group.my_security_group_rds.id]
}

output "ec2_ip" {
    value = aws_instance.my-instance.public_ip
}

output "rds_endpoint" {
    value = aws_db_instance.postgresql_rds_test.address
}

output "rds_port" {
    value = aws_db_instance.postgresql_rds_test.port
}
