resource "aws_security_group" "my_sc_http_lb" {
    description = "Enable HTTP for LB"
    name = "my_sc_http_lb"
    vpc_id = var.vpc_id

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
  subnets            = var.subnet_ids
}

resource "aws_lb_target_group" "lb-target-group-week4" {
  name     = "tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path = var.health_check_path
  }
}

resource "aws_lb_listener" "lb-listner" {
  load_balancer_arn = aws_lb.lb-week4.id
  port              = "80"

  default_action {
    target_group_arn = aws_lb_target_group.lb-target-group-week4.id
    type             = "forward"
  }
}