#!/bin/bash
aws s3api get-object --bucket vpc-random-name-aws-andriy-d-13123123 --key private-server.jar /private-server.jar

sudo yum update -y
sudo yum install java-1.8.0-openjdk -y

# to give ability connect to postgress from instance
sudo yum install -y postgresql-libs.x86_64 postgresql.x86_64

export RDS_HOST="${rds_host}"
touch "${rds_host}"
java -jar /private-server.jar