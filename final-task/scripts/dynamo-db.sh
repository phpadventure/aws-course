#!/bin/bash

# get all tables
aws dynamodb list-tables --region us-west-2

# get content of the table
aws dynamodb scan --table-name edu-lohika-training-aws-dynamodb --region us-west-2