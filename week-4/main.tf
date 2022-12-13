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

########NETWORK##########
resource "aws_vpc" "my-vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "week4"
  }
}

resource "aws_internet_gateway" "my-igw" {
  vpc_id = aws_vpc.my-vpc.id

  tags = {
    Name = "week4"
  }
}

resource "aws_subnet" "public-sb" {
  vpc_id     = aws_vpc.my-vpc.id
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone = "us-west-2a"

  tags = {
    Name = "week4"
  }
}

resource "aws_subnet" "private-sb" {
  vpc_id     = aws_vpc.my-vpc.id
  cidr_block = "10.0.2.0/24"
  map_public_ip_on_launch = false
  availability_zone = "us-west-2c"

  tags = {
    Name = "week4"
  }
}

resource "aws_route_table" "public-route" {
  vpc_id = aws_vpc.my-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my-igw.id
  }

  tags = {
    Name = "week4"
  }
}

resource "aws_route_table" "private-route" {
  vpc_id = aws_vpc.my-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    instance_id = aws_instance.public-nat.id
  }

  tags = {
    Name = "week4"
  }
}

resource "aws_route_table_association" "public-route-to-public-subnet" {
  subnet_id      = aws_subnet.public-sb.id
  route_table_id = aws_route_table.public-route.id
}

resource "aws_route_table_association" "private-route-to-private-subnet" {
  subnet_id      = aws_subnet.private-sb.id
  route_table_id = aws_route_table.private-route.id
}

resource "aws_security_group" "my_group_ssh_http" {
    description = "Enable HTTP access via port 80 + SSH access"
    name = "security_group_ssh_http"
    vpc_id = aws_vpc.my-vpc.id

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


#########EC2############
resource "aws_instance" "public-instance" {
    key_name = var.instance_ssh_key
    ami = var.instance_id
    instance_type = var.instance_type
    iam_instance_profile = aws_iam_instance_profile.ec2-access-profile.name
    user_data = "${file("init-ec2-public.sh")}"
    
    network_interface {
      network_interface_id = aws_network_interface.public-network-interface.id
      device_index         = 0
    }
}

resource "aws_network_interface" "public-network-interface" {
  subnet_id   = aws_subnet.public-sb.id
  security_groups = [aws_security_group.my_group_ssh_http.id]
  tags = {
    Name = "week4"
  }
}

resource "aws_instance" "public-nat" {
    key_name = var.instance_ssh_key
    ami = var.nat_instance_id
    instance_type = var.instance_type
    
    network_interface {
      network_interface_id = aws_network_interface.nat-network-interface.id
      device_index         = 0
    }
}

resource "aws_network_interface" "nat-network-interface" {
  subnet_id   = aws_subnet.public-sb.id
  security_groups = [aws_security_group.my_group_ssh_http.id]
  source_dest_check = false #!!!!! disable source/destination check
  tags = {
    Name = "week4"
  }
}

resource "aws_instance" "private-instance" {
    key_name = var.instance_ssh_key
    ami = var.instance_id
    instance_type = var.instance_type
    iam_instance_profile = aws_iam_instance_profile.ec2-access-profile.name
    user_data = "${file("init-ec2-private.sh")}"
    
    network_interface {
      network_interface_id = aws_network_interface.private-network-interface.id
      device_index         = 0
    }
}

resource "aws_network_interface" "private-network-interface" {
  subnet_id   = aws_subnet.private-sb.id
  security_groups = [aws_security_group.my_group_ssh_http.id]
  tags = {
    Name = "week4"
  }
}

########ROLE##########
resource "aws_iam_instance_profile" "ec2-access-profile" {
  name = "ec2-access-profile"
  role = aws_iam_role.ec2-access-role.name
  path = "/"
}

resource "aws_iam_role" "ec2-access-role" {
    name = "ec2-access-role"
    managed_policy_arns = ["arn:aws:iam::aws:policy/AmazonS3FullAccess"]
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
#########LOAD BALANCING#########
resource "aws_security_group" "my_sc_http_lb" {
    description = "Enable HTTP for LB"
    name = "my_sc_http_lb"
    vpc_id = aws_vpc.my-vpc.id

    ingress {
        description      = "HTTP from VPC"
        from_port        = 80
        to_port          = 80
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

resource "aws_lb" "lb-week4" {
  name               = "lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.my_sc_http_lb.id]
  subnets            = [aws_subnet.public-sb.id, aws_subnet.private-sb.id]

  tags = {
    Name = "week4"
  }
}

resource "aws_lb_target_group" "lb-target-group-week4" {
  name     = "tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.my-vpc.id
  target_type = "instance"
}

resource "aws_lb_target_group_attachment" "private-lb-attachment" {
  target_group_arn = aws_lb_target_group.lb-target-group-week4.arn
  target_id        = aws_instance.private-instance.id
  port             = 80
}

resource "aws_lb_target_group_attachment" "public-lb-attachment" {
  target_group_arn = aws_lb_target_group.lb-target-group-week4.arn
  target_id        = aws_instance.public-instance.id
  port             = 80
}

resource "aws_lb_listener" "lb-listner" {
  load_balancer_arn = aws_lb.lb-week4.id
  port              = "80"

  default_action {
    target_group_arn = aws_lb_target_group.lb-target-group-week4.id
    type             = "forward"
  }
}


####OUTPUT######
output "ec2_public_ip" {
    value = aws_instance.public-instance.public_ip
}

output "ec2_private_ip" {
    value = aws_instance.private-instance.private_ip
}

output "lb_endpoint" {
    value = aws_lb.lb-week4.dns_name
}