variable "project_name" {
  type    = string
  default = "bluebricks-demo"
}

variable "vpc_id" {
  type = string
}

variable "subnet_ids" {
  description = "List of subnet IDs (Private is best, but Public works for Default VPC)"
  type        = list(string)
}

variable "alb_security_group_id" {
  description = "Security Group ID of the ALB to allow traffic from"
  type        = string
}

variable "target_group_arn" {
  description = "ARN of the ALB Target Group to register instances with"
  type        = string
}

# --- Customer Inputs ---
variable "instance_type" {
  default = "t3.micro"
}

variable "container_port" {
  description = "Port the container listens on"
  type        = number
  default     = 80
}

variable "image_registry" {
  description = "Registry URL (e.g. 123.dkr.ecr...). Leave empty for Docker Hub."
  type        = string
  default     = "" 
}

variable "image_name" {
  description = "Image name (e.g. my-app or nginx)"
  type        = string
}

variable "image_tag" {
  description = "Docker image tag"
  type        = string
  default     = "latest"
}
