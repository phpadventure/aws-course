######VPC
- Create custom VPC. \
- Create private and public subnet in diff AZ. Enable in public subnet auto-assign public IP4 \
- Create public and private router table. And EXPLICITLY assign coresponding subnets for each router table. For assignment use another object in terraform aws_route_table_association.  \
- Create Inetrnet Gateway and create route in public router table all 0.0.0.0/0 traffic send on to IG. \
- Create NAT instance in EC2 in public subnet. Disable source/destination check. (It need to have public ip as AWS within public do it's own nat, otherwise instance will have no i-net) \
- To assign ec2 to subnet create a network inteface: `network_interface` in ec2 resource `aws_instance`. \
- Specific subnet and disable source/dest check should be set only in `network_interface`. Should be removed for ec2 resource. \
- Within NAT ec2 instance instance from private subnet will have connection to the i-net but no incomming requests. \
- Create route in public router table for hop 0.0.0.0/0 to send traffic on NAT ec2 instance. \
- Create and assing to all next and current ec2 instances securite group for ssh, http and https. \
- Create ec2 instances in private and public subnet. Instance should have role to get access to s3. \ 
- Create `init-s3.sh` script to create s3 bucket and upload ssh key. Create `s3-delete.sh` to destroy bucket later. \
- Create `init-ec2-public.sh` and `init-ec2-private.sh` scripts. Put ssh key and install appache and demo web page. Use it as user data for ec2 instances. \
- For LB create in terraform loadbalancer + target group  + target group attachment + listener. This will load balance traffic between public and private instance. \
- Execution flow. \
- install terraform if not done and add terraform extention for VScode and use default aws creds \
- exec `terraform init` to start and download ext \
- execute s3 script `sh inist-s3.sh` \
- `terraform plan` to see changes \
- `terraform apply` 
![output](https://github.com/phpadventure/aws-course/blob/master/week-4/screenshots/output.png) \
- ssh to public instance. Than ssh into private instance using uploaded key. Test private instacne can download from inet. `sudo yum update -y` \
`sudo ssh ec2-user@34.220.245.226  -i ~/.ssh/andriy.aws.pem` - use to ssh \
![i-net](https://github.com/phpadventure/aws-course/blob/master/week-4/screenshots/i-net.png) \
- open a few times load balancer endpoit to check it works \
![public-web](https://github.com/phpadventure/aws-course/blob/master/week-4/screenshots/public.png) \
![private-web](https://github.com/phpadventure/aws-course/blob/master/week-4/screenshots/private.png) \
- `terraform destroy` to destroy \
- run `sh s3-delete.sh` to clean s3 \
