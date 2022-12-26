resource "aws_iam_instance_profile" "ec2-access-profile" {
  name = "ec2-access-profile"
  role = aws_iam_role.ec2-access-role.name
  path = "/"
}

resource "aws_iam_role" "ec2-access-role" {
    name = "ec2-access-role"
    managed_policy_arns = ["arn:aws:iam::aws:policy/AmazonS3FullAccess", "arn:aws:iam::aws:policy/AmazonDynamoDBFullAccess", 
        "arn:aws:iam::aws:policy/AmazonSNSFullAccess", "arn:aws:iam::aws:policy/AmazonSQSFullAccess"]
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