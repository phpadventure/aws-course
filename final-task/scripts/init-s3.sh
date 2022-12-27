#!/bin/bash
aws s3api create-bucket --bucket vpc-random-name-aws-andriy-d-13123123 --region us-west-2  --create-bucket-configuration LocationConstraint=us-west-2
#aws s3api put-bucket-versioning --bucket vpc-random-name-aws-andriy-d-13123123 --versioning-configuration Status=Enabled
aws s3api put-object --bucket vpc-random-name-aws-andriy-d-13123123 --key key.pem --body ~/.ssh/andriy.aws.pem
current_dir=$(pwd -P)
aws s3api put-object --bucket vpc-random-name-aws-andriy-d-13123123 --key public-server.jar --body "$current_dir/java/calc-2021-0.0.1-SNAPSHOT.jar"
aws s3api put-object --bucket vpc-random-name-aws-andriy-d-13123123 --key private-server.jar --body "$current_dir/java/persist3-2021-0.0.1-SNAPSHOT.jar"