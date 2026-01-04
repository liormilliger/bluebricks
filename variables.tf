variable "region" {
  description = "AWS Region"
  type        = string
  default     = "us-east-2"
}

variable "project_name" {
  description = "Project naming convention"
  type        = string
  default     = "terraform-project"
}

variable "repository_url" {
  description = "The repository URL (e.g., Docker Hub or ECR)"
  type        = string
  default     = "index.docker.io" 
}

variable "image_name" {
  description = "The container image name"
  type        = string
  default     = "nginx"
}

variable "image_tag" {
  description = "The container image tag"
  type        = string
  default     = "latest"
}

variable "db_password" {
  description = "Password for the RDS instance"
  type        = string
  sensitive   = true
  default = "Password123!"
}