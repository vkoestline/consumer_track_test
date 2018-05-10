# Update the VM
sudo apt-get update

# Install unzip utility
sudo apt-get install unzip -y

# Create prerequisite directory
mkdir pre_files
cd pre_files

# Get Terraform version 11.7
wget https://releases.hashicorp.com/terraform/0.11.7/terraform_0.11.7_linux_amd64.zip 

# Unzip Terraform Zip
unzip terraform_0.11.7_linux_amd64.zip

# Copy the Terraform binary into your path
sudo cp terraform /usr/local/bin/

# Install Pip & AWSCLI
sudo apt install python-pip -y
pip install awscli --upgrade --user
pip install --upgrade pip

# Add AWSCLI to the user's PATH
export PATH=~/.local/bin:$PATH

# Configure AWS
aws configure
