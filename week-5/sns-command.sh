#!/bin/bash
aws s3api create-bucket --bucket vpc-random-name-aws-andriy-d-13123123 --region us-west-2  --create-bucket-configuration LocationConstraint=us-west-2
aws s3api put-bucket-versioning --bucket vpc-random-name-aws-andriy-d-13123123 --versioning-configuration Status=Enabled
aws s3api put-object --bucket vpc-random-name-aws-andriy-d-13123123 --key key.pem --body ~/.ssh/andriy.aws.pem