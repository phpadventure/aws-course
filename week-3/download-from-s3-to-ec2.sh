#!/bin/bash

aws s3api get-object --bucket week-3-aws-andriy-d --key collection.json /collection.json
aws s3api get-object --bucket week-3-aws-andriy-d --key rds-script.sql /rds-script.sql
aws s3api get-object --bucket week-3-aws-andriy-d --key dynamodb-script.sh /dynamodb-script.sh

sudo yum install -y postgresql-libs.x86_64 postgresql.x86_64