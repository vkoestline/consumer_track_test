# Technical Assessment for ConsumerTrack

# Problem Description

Purpose: To demonstrate you have a working knowledge AWS and can present a final product
with clear documentation and instructions for use.

Expected Result: A user should be able to visit the URL of an Elastic Load Balancer, and it
should return some details about the instance behind the load balancer. As the user refreshes
the ELB URL, the load balancer should send the user to another instance in a different
Availability Zone, the instance details should be presented to the browser.

Details:
Using whatever tools you like please create the following:

Elastic Load Balancer, Launch Configuration, Auto Scaling Group (Minimum of 3 instances in a minimum of 3 Availability Zones), and scripts to:

1. Install Nginx
2. Create an index.html file in the Nginx webroot that contains Instance ID, Instance Type, Private IP address of the instance, Availability zone the instance is in, and AMI ID.

You will also need to create security groups and other supporting resources to allow
connectivity. The rules of the security group and other supporting resources will not be
evaluated as part of this assessment, only required to allow connectivity.

# Product Design

This solutions uses Terraform to build the infrastructure as code in AWS.  The solution also uses a user_data shell script to install all necessary software on each of the nginx nodes and parameterizes the index.html file.   

Assumptions / Shortcuts:
- Uses default VPC
- Sets region to us-west-2.  Since the requirement is to have 3 availability zones.  
- Security groups on port 80 are open to the world.  All other ports are closed (no ssh access for troubleshooting).
- Tagging consists of only name.   In a real world scenario, we would set additional tags based on a set standard.
- Using the userdata script to create the index.html file sets the instance data as environment variables and then uses substitutions within an index.html template.  Ideally, we would manage the index.html using a configuration management tool (Puppet, Chef, etc).
- Cloudwatch alarms are set with arbitrary thresholds
- Scaling is on CPUUtilization 

# Prerequisites

You need the following tools to be able to launch this infrastructure/application.

- Terraform
- Unzip  
- An AWS account with appropriate accesses to launch infrastructure
- AWS CLI installed and configured
- AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY  

You can install all the prerequisite tools by either:

- running the prerequisites.sh file after cloning your repository (assumes nothing is previously installed)
- downloading the necessary tools separately

Example:

To run the prerequisites.sh script, type the following on a clean EC2 instance:

> `source prerequisites.sh`

To install the components separately, follow these instructions:

> `wget https://releases.hashicorp.com/terraform/0.11.7/terraform_0.11.7_linux_amd64.zip` 

> `sudo apt-get install unzip`

> `unzip terraform_0.11.7_linux_amd64.zip`

> `sudo cp terraform /usr/local/bin/`

> `sudo apt-get update`

> `sudo apt install python-pip`

> `sudo pip install awscli --upgrade --user`

> `sudo pip install --upgrade pip`

Update AWS configuration with AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY, and set the default region

> `aws configure`

> `AWS Access Key ID [****************PQOA]:` 

> `AWS Secret Access Key [****************lkig]: `

> `Default region name [us-west-2]:` 

> `Default output format [None]: `

# Install

On Ubuntu server:

> `git clone https://github.com/vkoestline/consumer_track_test.git consumer_track_test`


# Execute

To create infrastructure:

> `cd consumer_track_test`

If you need to run the prerequisite tools script, then

- > `source prerequisites.sh`  (make sure to configure AWS secret and access keys)

> `terraform init`

> `terraform apply -auto-approve`

You'll see the progress of the infrastructure as its being created.  When the process is complete, you will see the following information:

`Apply complete! Resources: 5 added, 0 changed, 0 destroyed.`

`Outputs:`

`nginx_domain = nginx-lb-537813355.us-west-2.elb.amazonaws.com`

The outputted value of the nginx_domain is the load balancer domain.  Copy the domain outputted to your screen and paste it into a browser.  

To test the load balancer hitting each node, refresh the page once every second to see the instance data 

![alt text](https://github.com/vkoestline/consumer_track_test/blob/master/documentation/consumer_track.gif "Nginx Node")

# Destroy

To destroy the infrastructure:

> `terraform destroy`



