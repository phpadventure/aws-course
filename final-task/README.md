######
-CLI user has all required access to create VPC, SQS, SNS, EC2, DynamoDB, RDC, IAM, S3





- Create SNS, SQS. Add required roles. Create a subscription for email for SNS.\
![output](https://github.com/phpadventure/aws-course/blob/master/week-5/screenshots/output.png) \
- log with ssh `sudo ssh ec2-user@34.220.245.226  -i ~/.ssh/andriy.aws.pem`
- exec command to push notification to sqs `aws sqs send-message --queue-url https://sqs.us-west-2.amazonaws.com/649094558971/tf-queue --message-body "Information about the largest city in Any Region." --delay-seconds 0  --region "us-west-2"` \
- exec to get notification from sqs `aws sqs receive-message --queue-url https://sqs.us-west-2.amazonaws.com/649094558971/tf-queue --attribute-names All --message-attribute-names All --max-number-of-messages 10  --region "us-west-2"` \
![sqs](https://github.com/phpadventure/aws-course/blob/master/week-5/screenshots/sqs.png)
- exec to push to sns email `aws sns publish --topic-arn "arn:aws:sns:us-west-2:649094558971:user-updates-topic" --message "Hello world" --region "us-west-2"` \
![sns-exec](https://github.com/phpadventure/aws-course/blob/master/week-5/screenshots/sns-exec.png)
![email](https://github.com/phpadventure/aws-course/blob/master/week-5/screenshots/email.png)
- `terraform destroy` to destroy \
