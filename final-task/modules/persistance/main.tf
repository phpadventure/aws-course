resource "aws_dynamodb_table" "dynamodb-table" {
    name = var.dynamodb_table_name
    billing_mode   = "PROVISIONED"
    read_capacity  = 20
    write_capacity = 20
    hash_key       = var.dynamodb_field_name

    attribute {
        name = var.dynamodb_field_name
        type = "S"
    }
}

resource "aws_db_instance" "postgresql_rds_test" {
  allocated_storage    = 10
  engine               = "postgres"
  instance_class       = "db.t3.micro"
  username             = var.db_user
  password             = var.db_pw
  skip_final_snapshot  = true
  vpc_security_group_ids = [aws_security_group.my_security_group_rds.id]
  db_subnet_group_name = aws_db_subnet_group.rds_group_default.name
  db_name               = "EduLohikaTrainingAwsRds" # HARD CODE DB NAME as connection failed
}

resource "aws_db_subnet_group" "rds_group_default" {
  name       = "rds_group_default"
  subnet_ids = var.rds_group_ids
}


resource "aws_security_group" "my_security_group_rds" {
    description = "Enable Postgres access"
    name = "my_security_group_rds"
    vpc_id = var.vpc_id

    ingress {
        description      = "Postgresql"
        from_port        = 5432
        to_port          = 5432
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