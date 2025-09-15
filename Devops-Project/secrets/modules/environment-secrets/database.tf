#server-secrets
data "tfe_workspace" "db" {
  organization = var.tfc-organization-name
  name         = "app-database-${var.environment}"
}

data "aws_db_instance" "rds" {
  tags = {
    Environment = var.environment
    Project    = "app"
    Application = "database"
  }
}

data "aws_secretsmanager_secret" "rds-password" {
  name = "app/database/${var.environment}/rds-password"
}

data "aws_secretsmanager_secret_version" "rds-password" {
  secret_id = data.aws_secretsmanager_secret.rds-password.id
}

#eks-secrets
data "tfe_workspace" "db-eks" {
  organization = var.tfc-organization-name
  name         = "eks-database-${var.environment}"
}

data "aws_db_instance" "rds-eks" {
  tags = {
    Environment = var.environment
    Project    = "eks"
    Application = "database"
  }
}

data "aws_secretsmanager_secret" "rds-eks-password" {
  name = "eks/database/${var.environment}/rds-password"
}

data "aws_secretsmanager_secret_version" "rds-eks-password" {
  secret_id = data.aws_secretsmanager_secret.rds-password.id
}

