#server-secrets
data "tfe_workspace" "infra-secrets" {
  organization = var.tfc-organization-name
  name         = "infra-secrets-${var.environment}"
}

resource "aws_secretsmanager_secret" "environment" {
  name                    = "${var.project}/${var.application}/${var.environment}/credentials"
  recovery_window_in_days = 0

  tags = {
    Environment = var.environment
    Project     = var.project
    Application = var.application
  }
}

locals {
  credentials    = jsonencode({
    RDS_NAME     = data.aws_db_instance.rds.db_name
    RDS_HOST     = data.aws_db_instance.rds.address
    RDS_PORT     = data.aws_db_instance.rds.port
    RDS_USERNAME = var.rds-username
    RDS_PASSWORD = data.aws_secretsmanager_secret_version.rds-password.secret_string
    DJANGO_PORT  = var.Django-port
    AWS_S3_BUCKET = data.tfe_outputs.devops-servers-development.values.s3_bucket_name
  })
}

resource "aws_secretsmanager_secret_version" "environment" {
  secret_id             = aws_secretsmanager_secret.environment.id
  secret_string         = local.credentials
  version_stages        = ["AWSCURRENT"]
}

#eks-secrets
resource "aws_secretsmanager_secret" "environment-eks" {
  name                    = "${var.project}/${var.application}/${var.environment}/eks-credentials"
  recovery_window_in_days = 0

  tags = {
    Environment = var.environment
    Project     = var.project
    Application = var.application
  }
}

locals {
  eks-credentials    = jsonencode({
    RDS_NAME     = data.aws_db_instance.rds-eks.db_name
    RDS_HOST     = data.aws_db_instance.rds-eks.address
    RDS_PORT     = data.aws_db_instance.rds-eks.port
    RDS_USERNAME = var.rds-username-eks
    RDS_PASSWORD = data.aws_secretsmanager_secret_version.rds-eks-password.secret_string
  })
}

resource "aws_secretsmanager_secret_version" "environment-eks" {
  secret_id            = aws_secretsmanager_secret.environment-eks.id
  secret_string        = local.eks-credentials
  version_stages       = ["AWSCURRENT"]
}
