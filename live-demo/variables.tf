variable "aws_region" {
  description = "AWS Region to deploy to"
  default     = "us-east-2"
}

variable "project_name" {
  default = "bluebricks-live-demo"
}
variable "vpc_id" {
  description = "The VPC ID where the solution will be deployed"
  type        = string
  # No default, forcing the customer to provide it
}

variable "app_image" {
  description = "The Docker image to run"
  default     = "nginx" # Easy demo: change to 'httpd' to show update
}

variable "app_port" {
  default = 80
}

variable "db_password" {
  description = "Database password"
  sensitive   = true
  default     = "password123!" # Change this for real use
}
