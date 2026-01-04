provider "aws" {
  region = var.region
}

module "network" {
  source       = "./modules/network"
  project_name = var.project_name
}

module "compute" {
  source             = "./modules/compute"
  project_name       = var.project_name
  vpc_id             = module.network.vpc_id
  subnets            = module.network.public_subnet_ids 
  security_group_id  = module.network.shared_sg_id
  
  repository_url     = var.repository_url
  image_name         = var.image_name
  image_tag          = var.image_tag
}

module "database" {
  source            = "./modules/database"
  project_name      = var.project_name
  subnets           = module.network.public_subnet_ids
  security_group_id = module.network.shared_sg_id
  db_password       = var.db_password
}