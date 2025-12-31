#!/bin/bash
exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1

echo "Starting User Data..."

yum update -y
amazon-linux-extras install docker
service docker start
systemctl enable docker
usermod -a -G docker ec2-user

REGISTRY_URL=$(echo "${image_repo}" | cut -d'/' -f1)

ECR_REGION=$(echo "$REGISTRY_URL" | cut -d'.' -f4)

echo "Detected ECR Region: $ECR_REGION"
echo "Logging into Registry: $REGISTRY_URL"

aws ecr get-login-password --region $ECR_REGION | docker login --username AWS --password-stdin $REGISTRY_URL

echo "Pulling image: ${image_repo}:${image_tag}"
docker run -d \
  --restart always \
  -p 80:${container_port} \
  ${image_repo}:${image_tag}