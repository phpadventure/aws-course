resource "aws_vpc" "my-vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "my-vpc"
  }
}

resource "aws_internet_gateway" "my-igw" {
  vpc_id = aws_vpc.my-vpc.id

  tags = {
    Name = "my-igw"
  }
}

resource "aws_subnet" "public-sb-1" {
  vpc_id     = aws_vpc.my-vpc.id
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone = "us-west-2a"

  tags = {
    Name = "public-sb"
  }
}

resource "aws_subnet" "public-sb-2" {
  vpc_id     = aws_vpc.my-vpc.id
  cidr_block = "10.0.2.0/24"
  map_public_ip_on_launch = true
  availability_zone = "us-west-2b"

  tags = {
    Name = "public-sb"
  }
}

resource "aws_route_table" "public-route" {
  vpc_id = aws_vpc.my-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my-igw.id
  }

  tags = {
    Name = "public-route-table"
  }
}

resource "aws_route_table_association" "public-route-to-public-subnet-1" {
  subnet_id      = aws_subnet.public-sb-1.id
  route_table_id = aws_route_table.public-route.id
}

resource "aws_route_table_association" "public-route-to-public-subnet-2" {
  subnet_id      = aws_subnet.public-sb-2.id
  route_table_id = aws_route_table.public-route.id
}


resource "aws_subnet" "private-sb-1" {
  vpc_id     = aws_vpc.my-vpc.id
  cidr_block = "10.0.3.0/24"
  map_public_ip_on_launch = false
  availability_zone = "us-west-2c"

  tags = {
    Name = "private-sb"
  }
}

resource "aws_subnet" "private-sb-2" {
  vpc_id     = aws_vpc.my-vpc.id
  cidr_block = "10.0.4.0/24"
  map_public_ip_on_launch = false
  availability_zone = "us-west-2d"

  tags = {
    Name = "private-sb"
  }
}

resource "aws_route_table" "private-route" {
  vpc_id = aws_vpc.my-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    instance_id = aws_instance.public-nat.id
  }

  tags = {
    Name = "private-router-table"
  }
}

resource "aws_route_table_association" "private-route-to-private-subnet-1" {
  subnet_id      = aws_subnet.private-sb-1.id
  route_table_id = aws_route_table.private-route.id
}

resource "aws_route_table_association" "private-route-to-private-subnet-2" {
  subnet_id      = aws_subnet.private-sb-2.id
  route_table_id = aws_route_table.private-route.id
}


### NAT EC2
resource "aws_instance" "public-nat" {
    key_name = var.instance_ssh_key
    ami = var.nat_instance_id
    instance_type = var.instance_type
    
    network_interface {
      network_interface_id = aws_network_interface.nat-network-interface.id
      device_index         = 0
    }

    tags = {
      Name = "NAT"
    }
}

resource "aws_network_interface" "nat-network-interface" {
  subnet_id   = aws_subnet.public-sb-1.id
  security_groups = [aws_security_group.nat-security-group.id]
  source_dest_check = false #!!!!! disable source/destination check
  tags = {
    Name = "NAT"
  }
}

resource "aws_security_group" "nat-security-group" {
    description = "Enable HTTP access via port 80 + SSH access"
    name = "nat-security-group-name"
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