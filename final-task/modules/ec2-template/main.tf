resource "aws_launch_template" "my_ec2_template" {
  name = "my_ec2_template_${var.template_name}"

  image_id = var.instance_id

  instance_type = var.instance_type

  key_name = var.instance_ssh_key

  vpc_security_group_ids = (var.vpc_security_group_id == "" ? null : [var.vpc_security_group_id])

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "ec2-instance-from-template-${var.template_name}"
      Template = "${var.template_name}"
    }
  }

  iam_instance_profile {
    arn = var.iam_instance_profile_arn
  }
  
  user_data = "${file(var.init_sh_file)}"
  #filebase64("${path.module}/example.sh")
}