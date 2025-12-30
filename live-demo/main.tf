# --- Artifact 1: Networking (ALB) ---
module "network" {
  source = "../artifacts/ALB"

  project_name   = var.project_name
  vpc_id         = var.vpc_id
#   public_subnets = data.aws_subnets.selected.ids
  public_subnets = [
    for az, subnet_ids in {
      for s in data.aws_subnet.details : s.availability_zone => s.id... 
    } : subnet_ids[0]
  ]  
  
  lb_port        = 80
}

# --- Artifact 2: Compute (ASG + App) ---
module "compute" {
  source = "../artifacts/compute"

  project_name          = var.project_name
  vpc_id                = var.vpc_id
  subnet_ids            = data.aws_subnets.selected.ids
  
  # Connects Compute to Network
  alb_security_group_id = module.network.alb_security_group_id
  target_group_arn      = module.network.target_group_arn

  # Customer Inputs
  image_repo     = var.app_image
  container_port = var.app_port
}

# --- Artifact 3: Database (RDS) ---
module "database" {
  source = "../artifacts/RDS"

  project_name = var.project_name
  vpc_id       = var.vpc_id
  subnet_ids   = data.aws_subnets.selected.ids

  # Connects DB to Compute
  compute_security_group_id = module.compute.security_group_id
  
  # Customer Inputs
  db_password = var.db_password
}
