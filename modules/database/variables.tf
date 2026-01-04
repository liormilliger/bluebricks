variable "project_name" {
  description = "The project name prefix used for naming the RDS instance"
  type        = string
}

variable "subnets" {
  description = "A list of subnet IDs where the RDS subnet group will be created"
  type        = list(string)
  default = module.network.public_subnet_ids
}

variable "security_group_id" {
  description = "The ID of the shared security group to attach to the RDS instance"
  type        = string
  default = module.network.shared_sg_id
}

variable "db_password" {
  description = "The master password for the RDS database"
  type        = string
  sensitive   = true
}