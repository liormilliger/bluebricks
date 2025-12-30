#!/bin/bash
# Enable logs to console for debugging
exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1

echo "Starting User Data..."

# 1. Install Docker on Amazon Linux 2
yum update -y
amazon-linux-extras install docker
service docker start
systemctl enable docker
usermod -a -G docker ec2-user

# 2. Run the Container
# Variables ${...} are replaced by Terraform before the instance starts
echo "Pulling image: ${image_repo}:${image_tag}"
docker run -d \
  --restart always \
  -p 80:${container_port} \
  ${image_repo}:${image_tag}

echo "Container started."