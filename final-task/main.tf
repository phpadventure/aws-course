provider "aws" {
    region = "us-west-2"
    profile = "default"
}

module "vpc" {
  source = "./modules/vpc"

  instance_ssh_key = var.instance_ssh_key
  vpc_cidr_block = var.vpc_cidr_block
  sb_public_cidr_block_1 = var.sb_public_cidr_block_1
  sb_public_cidr_block_2 = var.sb_public_cidr_block_2
  sb_private_cidr_block_1 = var.sb_private_cidr_block_1
  sb_private_cidr_block_2 = var.sb_private_cidr_block_2

  az_public_1 = var.az_public_1
  az_public_2 = var.az_public_2
  az_private_1 = var.az_private_1
  az_private_2 = var.az_private_2
}

module "sg_public" {
  source = "./modules/security-group"

  sg_name = "sg_public"
  vpc_id = module.vpc.vpc_id
  cidr_block = ["0.0.0.0/0"]
}

module "sg_private" {
  source = "./modules/security-group"

  sg_name = "sg_private"
  vpc_id = module.vpc.vpc_id
  cidr_block = [var.sb_public_cidr_block_1, var.sb_public_cidr_block_2]
}

module "instance_profile" {
  source = "./modules/access"
}

data "template_file" "private_init_script" {
  template = "${file(var.private_init_sh_file)}"

  vars = {
    rds_host = "${module.persistance.rds_endpoint}"
  }
}

module "ec2_template_private" {
  source = "./modules/ec2-template"

  instance_ssh_key = var.instance_ssh_key
  template_name = "private"
  user_data = "${base64encode(data.template_file.private_init_script.rendered)}"
  iam_instance_profile_arn = module.instance_profile.profile_arn

  depends_on = [
    module.persistance
  ]
}

module "ec2_template_public" {
  source = "./modules/ec2-template"

  vpc_security_group_id = module.sg_public.id
  instance_ssh_key = var.instance_ssh_key
  template_name = "public"
  user_data = "${filebase64(var.public_init_sh_file)}"
  iam_instance_profile_arn = module.instance_profile.profile_arn
}

#INSTNACES
##PRIVATE
resource "aws_instance" "private-instance" {
  launch_template {
    id =  module.ec2_template_private.template_id
    version = "$Latest"
  } 

  network_interface {
    network_interface_id = aws_network_interface.private-network-interface.id
    device_index         = 0
  }

  depends_on = [
    aws_network_interface.private-network-interface
  ]
}

resource "aws_network_interface" "private-network-interface" {
  subnet_id   = module.vpc.private_subnet_1_id
  security_groups = [module.sg_private.id]
  tags = {
    Name = "private-subnet-inteface"
  }
}
##Public instance - ASG
resource "aws_autoscaling_group" "my-asg" {
  desired_capacity   = 2
  max_size           = 3
  min_size           = 1

  launch_template {
    id      = module.ec2_template_public.template_id
    version = "$Latest"
  }

  vpc_zone_identifier = [
    module.vpc.public_subnet_1_id,
    module.vpc.public_subnet_2_id
  ]
}
#####

module "persistance" {
  source = "./modules/persistance" 

  dynamodb_table_name = var.dynamodb_table_name
  dynamodb_field_name = var.dynamodb_field_name

  db_user = var.db_user
  db_pw = var.db_pw
  rds_group_ids = [module.vpc.private_subnet_1_id, module.vpc.private_subnet_2_id]
  cidr_block = [var.sb_private_cidr_block_1, var.sb_private_cidr_block_2]   # ONLY PRIVATE
  vpc_id = module.vpc.vpc_id
}

module "notification" {
  source = "./modules/notification"

  email_to_subscribe = var.email_to_subscribe
  sns_topic_name = var.sns_topic_name
  sqs_name = var.sqs_name
}

module "load-balancer" {
  source = "./modules/load-balancer"

  vpc_id = module.vpc.vpc_id
  subnet_ids = [module.vpc.public_subnet_1_id, module.vpc.public_subnet_2_id]
  health_check_path = var.health_check_path
}

######MAP LOAD BALANCER TO ASG
resource "aws_autoscaling_attachment" "asg_attachment_to_lb" {
  autoscaling_group_name = aws_autoscaling_group.my-asg.id
  lb_target_group_arn    = module.load-balancer.target_group_arn
}

