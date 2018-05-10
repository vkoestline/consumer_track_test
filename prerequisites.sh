# Update the VM
sudo apt-get update

# Get Terraform version 11.7
wget https://releases.hashicorp.com/terraform/0.11.7/terraform_0.11.7_linux_amd64.zip

# Install unzip utility
sudo apt-get install unzip

# Unzip Terraform Zip
unzip terraform_0.11.7_linux_amd64.zip

# Copy the Terraform binary into your path
sudo cp terraform /usr/local/bin/

# Install Pip & AWSCLI
sudo apt install python-pip
sudo pip install --upgrade pip
sudo pip install awscli --upgrade --user

# Configure AWS
aws configure
