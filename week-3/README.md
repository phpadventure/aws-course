######RDS+DYNAMO-DB
- Give cli user access to DynamoDb, RDS, s3, ec2. \
- Create `init-s3.sh` script to create s3 bucket and upload files \
- `download-from-s3-to-ec2.sh` - moves files to ec2 instance and install postgress client in user data of terraform \
- `dynamodb-script.sh` and `collection.json` to add collection to the table \
- `rds-script.sql` to execute sql \
- execute s3 script `sh inist-s3.sh` in local \
![create-s3-upload-files](https://github.com/phpadventure/aws-course/blob/master/week-3/screenshots/create-s3-upload-files.png) \
- install terraform if not done and add terraform extention for VScode and use default aws creds \
- exec `terraform init` to start and download ext \
- `terraform plan` to see changes \
- `terraform apply -var="db_pw=Root1234$"` \
- output 
![output](https://github.com/phpadventure/aws-course/blob/master/week-3/screenshots/output.png) \
- `terraform state list => terraform state show <name>` to get ouput details \
- ssh to aws ec2 instance and see files in ec2 instance uplodaed from user_data `sudo ssh ec2-user@34.220.245.226  -i ~/.ssh/andriy.aws.pem` \
![files-in-ec2](https://github.com/phpadventure/aws-course/blob/master/week-3/screenshots/files-in-ec2.png) \
- run `sh dynamodb-script.sh` \
![dynamo-db](https://github.com/phpadventure/aws-course/blob/master/week-3/screenshots/dynamo-db.png) \
- run `psql -U root -h terraform-20221205174225352600000002.cxzyr3ymhgsa.us-west-2.rds.amazonaws.com -p 5432 -d postgres -a -f /rds-script.sql` \
![sql-result](https://github.com/phpadventure/aws-course/blob/master/week-3/screenshots/sql-result.png) \
- `terraform destroy` to destroy \
- run `sh s3-delete.sh` to clean s3
