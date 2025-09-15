module "new-db" {
  source = "./modules/new-workspace"

  environment       = "development"
  project           = "app"
  application       = "database"
}

module "new-db-eks" {
  source = "./modules/new-workspace"

  environment       = "development"
  project           = "eks"
  application       = "database"
}