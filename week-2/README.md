- Create init.sh script to create s3 bucket and upload file \
- execute s3 script `sh inist-s3.sh`\
![s3-file-deployed](https://github.com/phpadventure/aws-course/blob/master/week-2/screenshots/s3-file-deployed.png) \
- install terraform \
- add terragorm extention for VScode \
- learning terraform https://www.youtube.com/watch?v=SLB_c_ayRMo
- Set default profile to use credentials 
`https://registry.terraform.io/providers/hashicorp/aws/latest/docs#shared-configuration-and-credentials-files` \
- assign required roles for cli user \
- exec `terraform init` to start and download ext \
- `terraform apply`  User `-var-file` to specify file \
![deployed](https://github.com/phpadventure/aws-course/blob/master/week-2/screenshots/deployed.png) \
- `terraform destroy` to destroy \
- `terraform plan` to see changes \
- `terraform state list => terraform state show <name>` to get ouput details \
- ssh ans see test file in ec2 instance uplodaed from user_data `sudo ssh ec2-user@34.221.122.27  -i ~/.ssh/andriy.aws.pem` \
![ec2-file](https://github.com/phpadventure/aws-course/blob/master/week-2/screenshots/ec2-file.png) \