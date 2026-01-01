variable "project_name" {
  description = "Project name for resource tagging"
  type        = string
  default     = "bluebricks-demo"
}

variable "vpc_id" {
  description = "The VPC ID where the ALB will be deployed"
  type        = string
}

variable "lb_port" {
  description = "The port the Load Balancer listens on"
  type        = number
  default     = 80
}

variable "region" {
  description = "AWS Region to deploy resources into"
  type        = string
}

