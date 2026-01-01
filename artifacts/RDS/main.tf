provider "aws" {
  region = var.region
}

resource "aws_db_subnet_group" "this" {
  name       = "${var.project_name}-subnet-group"
  subnet_ids = var.private_subnet_ids

  tags = {
    Name = "${var.project_name}-subnet-group"
  }
}

resource "aws_db_instance" "this" {
  identifier        = "${var.project_name}-db"
  engine            = "postgres"
  engine_version    = "16"
  instance_class    = "db.t3.micro"
  allocated_storage = 20
  storage_type      = "gp3"

  db_name  = var.db_name
  username = var.db_username
  password = var.db_password

  db_subnet_group_name   = aws_db_subnet_group.this.name
  vpc_security_group_ids = [var.unified_security_group_id]
  
  # Security Best Practice: Even if subnets are public, don't expose DB
  publicly_accessible    = false
  skip_final_snapshot    = true # For demo purposes only

  tags = { Name = "${var.project_name}-db" }
}