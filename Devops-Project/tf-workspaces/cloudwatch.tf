module "cloudwatch-dev" {
  source = "./modules/new-workspace"

  environment  = "development"
  project      = "monitoring"
  application  = "cloudwatch"
} 