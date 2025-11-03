locals {
  env = terraform.workspace
}

module "ec2" {
  source = "./modules/Ec2"
  project = var.project
  env     = local.env
  ami = var.ami
  instance_type = var.instance_type
  vpc_id        = module.vpc.vpc_id 
  # subnet_ids = module.vpc.public_subnet_ids
  public_subnet_ids  = module.vpc.public_subnet_ids
  private_subnet_ids = module.vpc.private_subnet_ids
  key_name   = var.key_name
  public_key = var.public_key
  frontend_sg      = module.security_group.frontend_sg_id
  backend_sg      = module.security_group.backend_sg_id
  tags = merge(var.tags, { Environment = local.env })
}


module "s3" {
  source  = "./modules/S3"
  project = var.project
  env     = local.env
  bucket_name = "${var.project}-${local.env}-assets"
  tags = merge(var.tags, { Environment = local.env })
}


module "vpc" {
  source = "./modules/Vpc"
  project = var.project
  env     = local.env
  cidr_block = "10.0.0.0/16"

  public_subnets = {
    "${var.aws_region}a" = "10.0.1.0/24"
    "${var.aws_region}b" = "10.0.2.0/24"
  }
  
  private_subnets = {
    "${var.aws_region}a" = "10.0.3.0/24"
    "${var.aws_region}b" = "10.0.4.0/24"
  }
  

  
  tags = merge(var.tags, { Environment = local.env })
}

module "security_group" {
  source = "./modules/Security-group"
  vpc_id       = module.vpc.vpc_id 
  project      = var.project
  env          = local.env
  tags = merge(var.tags, { Name = "${var.project}-${var.env}-backend-sg" })
  
}

module "ALB" {
  source = "./modules/ALB"

  project             = var.project
  env                 = local.env
  vpc_id              = module.vpc.vpc_id
  public_subnet_ids   = module.vpc.public_subnet_ids
  backend_instance_id = module.ec2.backend_id
  alb_sg_id           = module.security_group.alb_sg_id

  tags = merge(var.tags, { Environment = local.env })
}
