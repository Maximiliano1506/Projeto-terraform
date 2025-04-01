module "vpc" {
  source = "./modules/vpc"
  project_name = var.project_name
  project_region = var.project_region
}

module "nginx_ec2" {
  source = "./modules/loadbalancer"
  project_name = var.project_name
  project_region = var.project_region
  vpc_id = module.vpc.vpc_id
  pub_subnets_id = module.vpc.pub_subnets_id
}

module "front-end" {
  source = "./modules/front-end"
  project_name = var.project_name
  project_region = var.project_region
  vpc_id = module.vpc.vpc_id
  priv_subnets_id = module.vpc.priv_subnets_id
}

module "back-end" {
  source = "./modules/back-end"
  project_name = var.project_name
  project_region = var.project_region
  vpc_id = module.vpc.vpc_id
  priv_subnets_id = module.vpc.priv_subnets_id
}
