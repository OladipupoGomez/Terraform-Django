module "networking-dev" {
  source = "./modules/dev-infra"

  providers = {
    aws = aws.us-east-1
  }

  environment  = var.environment
  application  = var.application
  project      = var.project
  vpc-name     = var.vpc-name
  vpc-name-eks = var.vpc-name-eks
  subnet-name  = var.subnet-name
  cidr-block   = var.cidr-block
  cidr-block-eks = var.cidr-block-eks
  region-code  = var.region-code
  subnet-count = var.subnet-count
  availability-zones = var.availability-zones
  postgres-port = var.postgres-port
  Django-port = var.Django-port
}