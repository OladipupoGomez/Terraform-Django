ephemeral "random_password" "rds-password" {
  length           = 20
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

resource "aws_secretsmanager_secret" "rds-password" {
  name                    = "${var.project}/${var.application}/${var.environment}/rds-password"
  recovery_window_in_days = 0

  tags = {
    EnvironmentCode = var.environment
    ProjectCode     = var.project
    ApplicationCode = var.application
  }
}

resource "aws_secretsmanager_secret_version" "rds-password" {
  secret_id                = aws_secretsmanager_secret.rds-password.id
  secret_string_wo         = ephemeral.random_password.rds-password.result
  secret_string_wo_version = 1
}

ephemeral "aws_secretsmanager_secret_version" "rds-password" {
  secret_id = aws_secretsmanager_secret_version.rds-password.secret_id
}
