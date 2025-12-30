variable "project_name" {
  type    = string
  default = "bluebricks-demo"
}

variable "vpc_id" {
  type = string
}

variable "subnet_ids" {
  description = "List of subnets for the DB Subnet Group"
  type        = list(string)
}

variable "compute_security_group_id" {
  description = "The Security Group ID of the EC2 instances (to allow access)"
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
  default     = "admin"
}

variable "db_password" {
  description = "Master password"
  type        = string
  default     = "password" # TODO: Change this in production!
  sensitive   = true       # Terraform will hide this in CLI output
}
