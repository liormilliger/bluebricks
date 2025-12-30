variable "project_name" {
  description = "Project name for resource tagging"
  type        = string
  default     = "bluebricks-demo"
}

variable "vpc_id" {
  description = "The VPC ID where the ALB will be deployed"
  type        = string
}

variable "public_subnets" {
  description = "List of public subnet IDs for the ALB"
  type        = list(string)
}

variable "lb_port" {
  description = "The port the Load Balancer listens on"
  type        = number
  default     = 80
}
