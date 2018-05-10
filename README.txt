What is this?

Design Decisions

Assumptions / Shortcuts:
- No Cloudwatch alarms are set
- No Scaling functionality 
- Did not create a separate VPC, instead using default
- Security groups on port 80 are open to the world, this would need to be adjusted
- Simple tagging with only name 
- Using userdata to create index file instead of puppet or other configuration management system


Prerequisites
- Need to have Terraform
- Need to have unzip utility 
- Need to have AWS CLI configured 
- Need to have an AWS account with AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY 
- Need to have proper AWS access to create resources 
- Ubuntu server to run test

Example:

On a clean EC2 instance
 
wget https://releases.hashicorp.com/terraform/0.11.7/terraform_0.11.7_linux_amd64.zip
sudo apt-get install unzip
unzip terraform_0.11.7_linux_amd64.zip
sudo cp terraform /usr/local/bin/

sudo apt-get update
sudo apt install python-pip
sudo pip install awscli --upgrade --user
sudo pip install --upgrade pip

# Update AWS configuration with AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY
aws configure

Install 

On Ubuntu server:
git clone https://github.com/vkoestline/consumer_track_test.git consumer_track_test

Execute

Run 'terraform apply -auto-approve' to create infrastructure

