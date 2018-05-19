# Nginx Cluster with Multiple Nodes

# Problem Description
Build an nginx cluster, with each node displays specific information that identifies the node

# Product Design

This solutions uses Terraform to build the infrastructure-as-code in AWS.  The solution also uses a user_data shell script to install all necessary software on each of the nginx nodes and parameterizes the index.html file.   

Assumptions / Shortcuts:
- Uses default VPC
- Sets region to us-west-2, since the requirement is to have 3 availability zones.  Otherwise, it uses all the AZ's in a region.
- Security groups on port 80 are open to the world.  All other ports are closed (no ssh access for troubleshooting).
- Tagging consists of only name.   In a real world scenario, we would set additional tags based on a set standard.
- Using the userdata script to create the index.html file sets the instance data as environment variables and then uses substitutions within an index.html template.  Ideally, we would manage the index.html using a configuration management tool (Puppet, Chef, etc).
- Cloudwatch alarms are set with arbitrary thresholds
- Scaling is on CPUUtilization

# Prerequisites

You need the following tools to be able to launch this infrastructure/application.

- Terraform
- Unzip utility
- An AWS account with appropriate accesses to launch infrastructure
- AWS CLI installed and configured
- AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY  
- Server running Ubuntu 16 (from which to launch the code)

# Installing Prerequisites 

You can install all the prerequisite tools on a clean Ubuntu instance, by doing the following:

Clone the repository

> `git clone https://github.com/vkoestline/nginx_cluster.git nginx_cluster`

> `cd nginx_cluster

then run:

> `source prerequisites.sh`

The script will install all needed software and run the AWS CLI configure command, which will prompt you to configure your AWS credentials to be able to run the Terraform code.

### AWS Credentials

Update AWS configuration with AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY, and set the default region

> `AWS Access Key ID [****************PQOA]:` 

> `AWS Secret Access Key [****************lkig]: `

> `Default region name [us-west-2]:` 

> `Default output format [None]: `

# Execute/Build Infrastructure

After you have installed the necessary tools, you can now launch the infrastructure.

To create the full nginx infrastructure, run the init function in the directory where the .tf files are located:

> `terraform init`

Then run apply to launch the changes.  

> `terraform apply -auto-approve`

You'll see the progress of the infrastructure as its being created.  When the process is complete, you will see the following information:

`Apply complete! Resources: 5 added, 0 changed, 0 destroyed.`

`Outputs:`

`nginx_domain` = **nginx-lb-XXXXXXXXX.us-west-2.elb.amazonaws.com**

The outputted value of the nginx_domain is the load balancer domain.  Copy the domain outputted to your screen and paste it into a browser.  

To test the load balancer hitting each node, refresh the page once every second to see the instance data 

# Destroy

To destroy the infrastructure:

> `terraform destroy -auto-approve`



