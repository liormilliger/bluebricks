module "network" {
  source = "../artifacts/ALB"

  project_name   = var.project_name
  vpc_id         = var.vpc_id
  lb_port        = 80
}

# --- Artifact 2: Compute (ASG + App) ---
module "compute" {
  source = "../artifacts/compute"

  project_name          = var.project_name
  vpc_id                = var.vpc_id
  subnet_ids            = module.network.public_subnets
  
  alb_security_group_id = module.network.alb_security_group_id
  target_group_arn      = module.network.target_group_arn
  image_name = var.app_image
  image_registry     = var.image_registry
  container_port = var.app_port
}

# --- Artifact 3: Database (RDS) ---
module "database" {
  source = "../artifacts/RDS"

  project_name = var.project_name
  vpc_id       = var.vpc_id
  subnet_ids   = data.aws_subnets.selected.ids
  compute_security_group_id = module.compute.security_group_id
  db_password = var.db_password
}
