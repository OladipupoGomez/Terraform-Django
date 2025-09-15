module "new-database" {
  source = "./modules/Rds"

  providers = {
    aws = aws.us-east-1
  }

  environment  = var.environment
  application  = var.application
  project      = var.project
  region-code  = var.region-code
  tfc-organization-name = var.tfc-organization-name
  rds-name = var.rds-name
  instance-size = var.instance-size
  storage-size = var.storage-size
  backup-window = var.backup-window
  maintenance-window = var.maintenance-window
  db-engine = var.db-engine
  db-engine-version = var.db-engine-version
  rds-username = var.rds-username
}