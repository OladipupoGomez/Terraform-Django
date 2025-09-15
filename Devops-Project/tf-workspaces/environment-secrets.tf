module "aws-secrets-development" {
  source = "./modules/new-workspace"

  environment       = "development"
  project           = "infra"
  application       = "secrets"
}