#!/bin/bash
# Install Docker
yum update -y
amazon-linux-extras install docker -y
service docker start
usermod -a -G docker ec2-user

# Variables injected by Terraform
REPO_URL="${repo_url}"
IMAGE="${image_name}"
TAG="${image_tag}"

# Construct full image name
# If repo is docker hub (default), standard format. If ECR, full path.
FULL_IMAGE="$REPO_URL/$IMAGE:$TAG"

# If using ECR, login (requires IAM permissions)
if [[ "$REPO_URL" == *".amazonaws.com"* ]]; then
  REGION=$(curl -s http://169.254.169.254/latest/meta-data/placement/region)
  aws ecr get-login-password --region $REGION | docker login --username AWS --password-stdin $REPO_URL
fi

# Run the container
docker run -d -p 80:80 $FULL_IMAGE