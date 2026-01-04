variable "project_name" {
  description = "The project name prefix used for naming EC2, ALB, and IAM resources"
  type        = string
}

variable "vpc_id" {
  description = "The ID of the VPC where the compute resources will be deployed"
  type        = string
  default = module.network.vpc_id
}

variable "subnets" {
  description = "A list of subnet IDs where the Auto Scaling Group and Load Balancer will reside"
  type        = list(string)
  default = module.network.public_subnet_ids
}

variable "security_group_id" {
  description = "The ID of the shared security group to attach to instances and the ALB"
  type        = string
  default = module.network.shared_sg_id
}

variable "repository_url" {
  description = "The repository URL for the application image (injected into User Data)"
  type        = string
  default = "https://hub.docker.com/"
}

variable "image_name" {
  description = "The name of the docker image (injected into User Data)"
  type        = string
}

variable "image_tag" {
  description = "The tag of the docker image (injected into User Data)"
  type        = string
  default = "latest"
}