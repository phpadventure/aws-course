#!/bin/bash
aws s3api create-bucket --bucket week-3-aws-andriy-d --region us-west-2  --create-bucket-configuration LocationConstraint=us-west-2
aws s3api put-bucket-versioning --bucket week-1-aws-andriy-28-11-2022 --versioning-configuration Status=Enabled
aws s3api put-object --bucket week-3-aws-andriy-d --key collection.json --body collection.json
aws s3api put-object --bucket week-3-aws-andriy-d --key dynamodb-script.sh --body dynamodb-script.sh
aws s3api put-object --bucket week-3-aws-andriy-d --key rds-script.sql --body rds-script.sql