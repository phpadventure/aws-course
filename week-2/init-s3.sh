#!/bin/bash
touch test.txt
aws s3api create-bucket --bucket week-1-aws-andriy-28-11-2022 --region us-west-2  --create-bucket-configuration LocationConstraint=us-west-2
aws s3api put-bucket-versioning --bucket week-1-aws-andriy-28-11-2022 --versioning-configuration Status=Enabled
aws s3api put-object --bucket week-1-aws-andriy-28-11-2022 --key local_test.txt --body test.txt