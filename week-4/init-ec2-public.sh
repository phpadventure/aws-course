#!/bin/bash
aws s3api get-object --bucket vpc-random-name-aws-andriy-d-13123123 --key key.pem /key.pem

sudo su
chmod 400 /key.pem
yum update -y
yum install httpd -y
service httpd start
chkconfig httpd on
cd /var/www/html
echo "<html><h1>This is WebServer from PUBLIC subnet</h1></html>" > index.html