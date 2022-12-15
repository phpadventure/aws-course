#!/bin/bash
aws sns publish --topic-arn "arn:aws:sns:us-west-2:649094558971:user-updates-topic" --message "Hello world" --region "us-west-2"