- use US West (Oregon) Region (us-west-2) \
- Create EC2 instance through console in AWS \
- Create script for cloudformation \
- run script through web console \
- run script with cli \

####pre-requirements
- create account with MFA


####Step1
- created EC2\
- created custom security group ![security_group](https://github.com/phpadventure/aws-course/blob/master/week-0/screenshots/custom-security.png) \
- attached securiity group ![security_attched](https://github.com/phpadventure/aws-course/blob/master/week-0/screenshots/instance-with-security.png) \ 
- test connection with telnet for 22 and 80 (newly added security group) \
![ssh](https://github.com/phpadventure/aws-course/blob/master/week-0/screenshots/success-22.png) \
![web](https://github.com/phpadventure/aws-course/blob/master/week-0/screenshots/succes-80-but-no-service.png) \

- delete all => terminate instance \

####Step2
- create yaml for CloudFormation \
- execute with web console\
![web-console-events](https://github.com/phpadventure/aws-course/blob/master/week-0/screenshots/web-console-events.png) \
![web-console-output](https://github.com/phpadventure/aws-course/blob/master/week-0/screenshots/web-console-output.png) \
![ssh](https://github.com/phpadventure/aws-course/blob/master/week-0/screenshots/web-console-stack-ready.png) \

####Step3
- Install aws cli https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html \
- curl "https://awscli.amazonaws.com/AWSCLIV2.pkg" -o "AWSCLIV2.pkg" \
- sudo installer -pkg AWSCLIV2.pkg -target \
- configure defualt profile (will be located ~/.aws/credentials) \
`aws configure` \
to create secrets got IAM-> Users-> Security credentials->access key \
- aws API for cloudformation https://docs.aws.amazon.com/cli/latest/reference/cloudformation/index.html \
- execute from console \
`aws cloudformation create-stack --stack-name week0-ec2 --template-body file:///Users/adobush/development/aws-course/aws-course/week-0/ec2-instance.yaml` \
- describe stack \
`aws cloudformation describe-stacks --stack-name week0-ec2` \
- delete stack \
`aws cloudformation delete-stack --stack-name week0-ec2` \
![stack-with-cli](https://github.com/phpadventure/aws-course/blob/master/week-0/screenshots/stack-with-cli.png) \


