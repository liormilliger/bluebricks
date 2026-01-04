terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket         = "liorm-bluebricks"
    key            = "newtfstate/terraform.tfstate"
    region         = "us-east-2"
    encrypt        = true
    dynamodb_table = "new-liorm-bluebricks-locks"
  }
}