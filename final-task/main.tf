provider "aws" {
    region = "us-west-2"
    profile = "default"
}

module "vpc" {
  source = "./modules/vpc"

  instance_ssh_key = var.instance_ssh_key
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
  cidr_block = ["10.0.1.0/24", "10.0.2.0/24"]
}

module "instance_profile" {
  source = "./modules/access"
}

module "ec2_template_private" {
  source = "./modules/ec2-template"

  instance_ssh_key = var.instance_ssh_key
  template_name = "private"
  init_sh_file = "${var.private_init_sh_file} ${module.persistance.rds_endpoint}" # HOST OF RDS IS PASSED AS PARAMS TO A FILE
  iam_instance_profile_arn = module.instance_profile.profile_arn
}

module "ec2_template_public" {
  source = "./modules/ec2-template"

  vpc_security_group_id = module.sg_public.id
  instance_ssh_key = var.instance_ssh_key
  template_name = "public"
  init_sh_file = var.public_init_sh_file
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
  cidr_block = ["10.0.3.0/24", "10.0.4.0/24"]   # ONLY PRIVATE
}

