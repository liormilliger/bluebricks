variable "project_name" {
  type    = string
  default = "bluebricks-demo"
}

variable "region" {
  description = "AWS Region to deploy resources into"
  type        = string
}

variable "vpc_id" {
  type = string
}

variable "private_subnet_ids" {
  description = "List of subnets for the DB Subnet Group"
  type        = list(string)
}

variable "unified_security_group_id" {
  description = "Unified Security Group ID from the ALB Module"
  type        = string
}

# --- Customer Inputs ---
variable "db_name" {
  description = "Name of the database to create"
  type        = string
  default     = "bluebricks"
}

variable "db_username" {
  description = "Master username"
  type        = string
  default     = "lior"
}

variable "db_password" {
  description = "Master password"
  type        = string
  default     = "password" # TODO: Change this in production!
  sensitive   = true       # Terraform will hide this in CLI output
}
