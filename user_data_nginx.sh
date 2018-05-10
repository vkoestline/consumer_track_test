#!/bin/bash

# Set hostname dynamically
sudo hostname nginx
sudo echo '127.0.0.1 nginx' >> /etc/hosts

# update ubuntu
sudo apt-get update

# install nginx
sudo apt-get install nginx -y
sudo service nginx stop

# set required environment variables
AWS_INSTANCE_ID=$(curl http://169.254.169.254/latest/meta-data/instance-id)
AWS_INSTANCE_TYPE=$(curl http://169.254.169.254/latest/meta-data/instance-type)
AWS_PRIVATE_IP=$(curl http://169.254.169.254/latest/meta-data/local-ipv4)
AWS_AZ=$(curl http://169.254.169.254/latest/meta-data/placement/availability-zone)
AWS_AMI_ID=$(curl http://169.254.169.254/latest/meta-data/ami-id)

# write index file
sudo cat <<EOF > /var/www/html/index.html
${index_file}
EOF

# update index with metadata
sudo sed -i 's/AWS_INSTANCE_ID/'"$AWS_INSTANCE_ID"'/g' /var/www/html/index.html
sudo sed -i 's/AWS_INSTANCE_TYPE/'"$AWS_INSTANCE_TYPE"'/g' /var/www/html/index.html
sudo sed -i 's/AWS_PRIVATE_IP/'"$AWS_PRIVATE_IP"'/g' /var/www/html/index.html
sudo sed -i 's/AWS_AZ/'"$AWS_AZ"'/g' /var/www/html/index.html
sudo sed -i 's/AWS_AMI_ID/'"$AWS_AMI_ID"'/g' /var/www/html/index.html

# restart nginx
sudo service nginx start
