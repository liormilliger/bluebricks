variable "project_name" {
    type = string 
    description = "The project name prefix used to tag VPC, subnets, and security groups"    
    default = "lior-bluebricks"
}

variable "region" {
  type = string
  default = "us-east-2"
}