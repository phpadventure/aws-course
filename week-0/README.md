- use US West (Oregon) Region (us-west-2) \
- Create EC2 instance through console in AWS \
- Create script for cloudformation \
- run script through web console \
- run script with cli \

####pre-requirements
- create account with MFA


####Step1
- created EC2\
- created custom security group ![security_group](https://github.com/phpadventure/aws-course/blob/master/week-0/screenshot/custom-security.png) \
- attached securiity group ![security_attched](https://github.com/phpadventure/aws-course/blob/master/week-0/screenshot/instance-with-security.png) \ 
- test connection with telnet for 22 and 80 (newly added security group) \
![ssh](https://github.com/phpadventure/aws-course/blob/master/week-0/screenshot/success-22.png) \
![web](https://github.com/phpadventure/aws-course/blob/master/week-0/screenshot/succes-80-but-no-service.png) \

- delete all => terminate instance \

####Step2
- create yaml for CloudFormation \
- execute with web console\
![web-console-events](https://github.com/phpadventure/aws-course/blob/master/week-0/screenshot/web-console-events.png) \
![web-console-output](https://github.com/phpadventure/aws-course/blob/master/week-0/screenshot/web-console-output.png) \
![ssh](https://github.com/phpadventure/aws-course/blob/master/week-0/screenshot/web-console-stack-ready.png) \

####Step3
- Instal aws cli \
