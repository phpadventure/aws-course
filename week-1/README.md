- Create autoscalling template and group. \
- Note security group worked only with Group Id \
- User data should be base 64 encoded \
- to pass user data as file used param and pass encoded file content \
- run with aws cli `aws cloudformation create-stack --stack-name week1-ec2 --template-body file:///Users/adobush/development/aws-course/aws-course/week-1/ec2-instance.yaml --parameters ParameterKey=MyUserData,ParameterValue=$(base64 -i init.sh)` \

![event](https://github.com/phpadventure/aws-course/blob/master/week-1/screenshots/event.png) \
![status](https://github.com/phpadventure/aws-course/blob/master/week-1/screenshots/status.png) \
![cli](https://github.com/phpadventure/aws-course/blob/master/week-1/screenshots/cli.png) \

- ssh `sudo ssh ec2-user@35.85.34.131 -i ~/.ssh/andriy.aws.pem` \
- java
![java](https://github.com/phpadventure/aws-course/blob/master/week-1/screenshots/java.png) \
- delete `aws cloudformation delete-stack --stack-name week1-ec2` \


######
- https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-template-resource-type-ref.html \
- https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-properties-as-group.html#cfn-autoscaling-autoscalinggroup-autoscalinggroupname\
- https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-ec2-launchtemplate.html \
- https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/user-data.html \
- blue/green deployment https://aws.amazon.com/blogs/compute/retaining-metrics-across-blue-green-deployment-for-predictive-scaling/?sc_icampaign=pac_predictive-scaling_ec2autoscaling&sc_ichannel=ha&sc_icontent=awssm-10052_pac&sc_iplace=aws-console-ec2autoscaling&trk=ha_awssm-10052_pac


