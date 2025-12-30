terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  # --- BACKEND CONFIGURATION ---
  # Note: The Bucket and DynamoDB table must exist BEFORE running 'terraform init'
  backend "s3" {
    bucket         = "bluebricks"                     # CHANGE THIS to a unique name if needed
    key            = "tfstate/terraform.tfstate"      # This creates the 'tfstate' folder
    region         = "us-east-1"                      # Must match your bucket's region
    encrypt        = true
    dynamodb_table = "bluebricks-locks"               # Table for state locking
  }
}

provider "aws" {
  region = var.aws_region
}

data "aws_subnets" "selected" {
  filter {
    name   = "vpc-id"
    values = [var.vpc_id]
  }
}

data "aws_subnet" "details" {
  for_each = toset(data.aws_subnets.selected.ids)
  id       = each.value
}
