#!/bin/bash
aws s3api get-object --bucket vpc-random-name-aws-andriy-d-13123123 --key private-server.jar /private-server.jar

sudo yum update -y
sudo yum install java-1.8.0-openjdk -y

#RDS HOST passed as first argument
export RDS_HOST=${rds_host}
sudo java -jar /private-server.jar