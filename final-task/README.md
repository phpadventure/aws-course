######
- CLI user has all required access to create VPC, SQS, SNS, EC2, DynamoDB, RDC, IAM, S3
- task is located in infra.docx
- used modules. For user data with vars used `data.template_file`
- run from root project directory `sh scripts/init-s3.sh`
- run `terraform init`
- run `terraform apply` \
![output](https://github.com/phpadventure/aws-course/blob/master/final-task/screenshots/output.png) 
- email subscription result \
![subsciption_email](https://github.com/phpadventure/aws-course/blob/master/final-task/screenshots/subsciption_email.png.png)
![subscription_confirmed](https://github.com/phpadventure/aws-course/blob/master/final-task/screenshots/subscription_confirmed.png)
- run locally `java -cp calc-client-1.0-SNAPSHOT-jar-with-dependencies.jar CalcClient lb-1568405298.us-west-2.elb.amazonaws.com`. Previously insall java 8. \
![start_client](https://github.com/phpadventure/aws-course/blob/master/final-task/screenshots/start_client.png)
- received emails \
![notification_on_email](https://github.com/phpadventure/aws-course/blob/master/final-task/screenshots/notification_on_email.png)
- kill one instance from ASG \
![terminated_instance](https://github.com/phpadventure/aws-course/blob/master/final-task/screenshots/terminated_instance.png)
- app response from one isntance only
![result_from_one_instance](https://github.com/phpadventure/aws-course/blob/master/final-task/screenshots/result_from_one_instance.png)
- asg raised instance automatically. Response from two
![asg_instance_raise_up](https://github.com/phpadventure/aws-course/blob/master/final-task/screenshots/asg_instance_raise_up.png)
![response_from_multiple_instance](https://github.com/phpadventure/aws-course/blob/master/final-task/screenshots/response_from_multiple_instance.png)
- ssh to public instance `sudo ssh ec2-user@54.187.243.195  -i ~/.ssh/andriy.aws.pem`
- `aws dynamodb list-tables --region us-west-2` to get all table
- `aws dynamodb scan --table-name edu-lohika-training-aws-dynamodb --region us-west-2`  to get table content \
![dynamo_db_contnent](https://github.com/phpadventure/aws-course/blob/master/final-task/screenshots/dynamo_db_contnent.png)
- `sudo chmod 400 /key.pem`
- ssh to private instance public  `sudo ssh ec2-user@10.0.3.18  -i /key.pem`
- login into psql client `psql -U rootuser -h terraform-20221228210556780400000003.cxzyr3ymhgsa.us-west-2.rds.amazonaws.com  -p 5432 -d postgres`
- use `\l` to show all dbs
- use `\c EduLohikaTrainingAwsRds`
- use `SELECT * FROM LOGS;`
- to destroy run `terraform destroy`
- clean up s3 `sh scripts/delete-s3.sh`