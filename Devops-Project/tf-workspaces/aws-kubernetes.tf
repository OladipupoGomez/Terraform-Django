module "aws-development-kubernetes" {
  source = "./modules/new-workspace"

  environment       = "development"
  project           = "devops"
  application       = "kubernetes"
}