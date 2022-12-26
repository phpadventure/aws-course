#!/bin/bash
aws s3api get-object --bucket vpc-random-name-aws-andriy-d-13123123 --key key.pem /key.pem
aws s3api get-object --bucket vpc-random-name-aws-andriy-d-13123123 --key public-server.jar /public-server.jar

sudo yum update -y
sudo yum install java-1.8.0-openjdk -y

sudo java -jar /public-server.jar