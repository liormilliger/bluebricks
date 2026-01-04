resource "aws_db_subnet_group" "default" {
  name       = "${var.project_name}-db-subnet-group"
  subnet_ids = var.subnets

  tags = { Name = "${var.project_name} DB subnet group" }
}

resource "aws_db_instance" "default" {
  identifier             = "${var.project_name}-db"
  allocated_storage      = 20
  storage_type           = "gp3"
  engine                 = "postgres"
  engine_version         = "16"
  instance_class         = "db.t3.micro"
  db_name                = "appdb"
  username               = "liormilliger"
  password               = var.db_password
  parameter_group_name   = "default.postgres16"
  skip_final_snapshot    = true
  publicly_accessible    = true # Per requirement (on public subnet)
  
  db_subnet_group_name   = aws_db_subnet_group.default.name
  vpc_security_group_ids = [var.security_group_id]
}