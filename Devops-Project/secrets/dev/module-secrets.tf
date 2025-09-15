# The module block remains the same, it's the source of the resources.
module "environment-secrets" {
  source = "./modules/environment-secrets"

  providers = {
    aws = aws.us-east-1
  }

  environment           = var.environment
  application           = var.application
  project               = var.project
  region-code           = var.region-code
  Django-port           = var.Django-port
  rds-username          = var.rds-username
  rds-username-eks      = var.rds-username-eks
  tfc-organization-name = var.tfc-organization-name 
}

output "RDS_NAME" {
  value = module.environment-secrets.rds_db_name
  sensitive = true
}

output "RDS_HOST" {
  value = module.environment-secrets.rds_host
  sensitive = true
}

output "RDS_PORT" {
  value = module.environment-secrets.rds_port
  sensitive = true
}

output "RDS_PASSWORD" {
  value     = module.environment-secrets.rds_password
  sensitive = true
}

output "RDS_USERNAME" {
  value     = var.rds-username-eks
  sensitive = true
}