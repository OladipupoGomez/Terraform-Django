module "cloudwatch" {
  source = "./modules/cloudwatch"

  providers = {
    aws = aws.us-east-1
  }

  environment = var.environment
  application = var.application
  project     = var.project
  aws-region  = var.aws-region
  tfc-organization-name = var.tfc-organization-name
}