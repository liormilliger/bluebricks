module "network" {
  source = "../artifacts/ALB"

  region         = var.region
  project_name   = var.project_name
  vpc_id         = var.vpc_id
  lb_port        = 80
}

module "compute" {
  source = "../artifacts/compute"

  project_name          = var.project_name
  region                = var.region
  vpc_id                = var.vpc_id
  public_subnet_ids            = module.network.public_subnets
  
  unified_security_group_id = module.network.unified_security_group_id
  target_group_arn      = module.network.target_group_arn
  image_name = var.app_image
  image_registry     = var.image_registry
  container_port = var.app_port
}

module "database" {
  source = "../artifacts/RDS"

  project_name = var.project_name
  region         = var.region
  vpc_id       = var.vpc_id
  private_subnet_ids   = module.network.private_subnets
  unified_security_group_id = module.network.unified_security_group_id
  db_password = var.db_password
}
