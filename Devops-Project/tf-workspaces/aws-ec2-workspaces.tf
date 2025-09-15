module "instances-dev" {
  source = "./modules/new-workspace"

  environment  = "development"
  project      = "devops"
  application  = "servers"
} 