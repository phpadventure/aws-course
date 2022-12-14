provider "aws" {
    region = "us-west-2"
    profile = "default"
}

#######VARS#######
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

variable "email_to_subscribe" {
    description = "Email for sns"
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
    ingress {
        description      = "HTTPS from VPC"
        from_port        = 443
        to_port          = 443
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

#####SQS########
resource "aws_sqs_queue" "my-queue" {
  name                      = "tf-queue"
  delay_seconds             = 10
  max_message_size          = 2048
  message_retention_seconds = 86400
  receive_wait_time_seconds = 0
}

#####SNS########
resource "aws_sns_topic" "my-topic" {
  name = "user-updates-topic"
}

resource "aws_sns_topic_subscription" "my-topic-subscription" {
  topic_arn = aws_sns_topic.my-topic.arn
  protocol  = "email"
  endpoint  = var.email_to_subscribe
}


#########EC2############
resource "aws_instance" "public-instance" {
    key_name = var.instance_ssh_key
    ami = var.instance_id
    instance_type = var.instance_type
    iam_instance_profile = aws_iam_instance_profile.ec2-access-profile.name
    security_groups = [aws_security_group.my_group_ssh_http.name]
}

########ROLE##########
resource "aws_iam_instance_profile" "ec2-access-profile" {
  name = "ec2-access-profile"
  role = aws_iam_role.ec2-access-role.name
  path = "/"
}

resource "aws_iam_role" "ec2-access-role" {
    name = "ec2-access-role"
    managed_policy_arns = ["arn:aws:iam::aws:policy/AmazonSNSFullAccess", "arn:aws:iam::aws:policy/AmazonSQSFullAccess"]
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


####OUTPUT######
output "ec2_public_ip" {
    value = aws_instance.public-instance.public_ip
}

output "sqs_arn" {
  value = aws_sqs_queue.my-queue.arn
}

output "sqs_url" {
  value = aws_sqs_queue.my-queue.url
}

output "sns_arn" {
  value = aws_sns_topic.my-topic.arn
}