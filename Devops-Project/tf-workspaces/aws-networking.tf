module "aws-development-networking" {
  source = "./modules/new-workspace"

  environment       = "development"
  project           = "infra"
  application       = "networking"
}