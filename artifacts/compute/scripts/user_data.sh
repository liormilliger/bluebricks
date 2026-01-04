#!/bin/bash
exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1

echo "Starting User Data..."

# --- 1. Install Docker ---
yum update -y
amazon-linux-extras install docker
service docker start
systemctl enable docker
usermod -a -G docker ec2-user

# --- 2. Parse Inputs ---
# Variables injected by Terraform templatefile
REGISTRY="${image_repo}"   # e.g., "123.dkr.ecr.us-east-2.amazonaws.com" or empty
IMAGE="${image_name}"        # e.g., "my-app"
TAG="${image_tag}"           # e.g., "v1" or empty

# Default to "latest" if TAG is empty
if [ -z "$TAG" ]; then
  TAG="latest"
fi

# --- 3. Construct Full Image URI & Handle Login ---
if [ -z "$REGISTRY" ]; then
  # CASE A: Docker Hub (No Registry URL provided)
  FULL_IMAGE="$IMAGE:$TAG"
  echo "Registry URL is empty. Defaulting to Docker Hub."
  echo "Image URI: $FULL_IMAGE"
  # No login needed for public Docker Hub images
  
else
  # CASE B: Private ECR (Registry URL is present)
  # Check if it looks like an ECR URL to perform login
  if [[ "$REGISTRY" == *"amazonaws.com"* ]]; then
    # Extract Region from URL (e.g., 123.dkr.ecr.us-east-2.amazonaws.com)
    ECR_REGION=$(echo "$REGISTRY" | cut -d'.' -f4)
    
    echo "Detected ECR Registry: $REGISTRY"
    echo "Region: $ECR_REGION"
    
    # Perform ECR Login (Relies on EC2 IAM Role)
    aws ecr get-login-password --region $ECR_REGION | docker login --username AWS --password-stdin $REGISTRY
  fi

  # Construct full URI: registry/image:tag
  FULL_IMAGE="$REGISTRY/$IMAGE:$TAG"
  echo "Image URI: $FULL_IMAGE"
fi

# --- 4. Run Container ---
echo "Starting container..."
docker run -d \
  --restart always \
  -p 80:${container_port} \
  $FULL_IMAGE

echo "Container started."