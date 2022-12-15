#!/bin/bash
aws sqs send-message --queue-url https://sqs.us-west-2.amazonaws.com/649094558971/tf-queue --message-body "Information about the largest city in Any Region." --delay-seconds 0  --region "us-west-2"

aws sqs receive-message --queue-url https://sqs.us-west-2.amazonaws.com/649094558971/tf-queue --attribute-names All --message-attribute-names All --max-number-of-messages 10  --region "us-west-2"