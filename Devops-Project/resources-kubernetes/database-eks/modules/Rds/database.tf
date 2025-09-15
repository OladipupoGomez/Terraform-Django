resource "aws_db_instance" "django-eks" {
  instance_class    = var.instance-size
  allocated_storage = var.storage-size
  storage_type      = "gp3"

  allow_major_version_upgrade = false
  apply_immediately           = false

  backup_retention_period  = 7
  backup_target            = "region"
  delete_automated_backups = true

  backup_window      = var.backup-window
  maintenance_window = var.maintenance-window

  database_insights_mode = "standard"

  identifier_prefix    = "${var.project}-${var.application}-${var.environment}"
  db_name              = var.rds-name-eks
  parameter_group_name = aws_db_parameter_group.django-eks.id
  username             = var.rds-username
  engine               = "postgres"
  engine_version           = var.db-engine-version
  engine_lifecycle_support = "open-source-rds-extended-support"
  license_model            = "postgresql-license"
  password_wo              = ephemeral.aws_secretsmanager_secret_version.rds-password.secret_string
  password_wo_version      = aws_secretsmanager_secret_version.rds-password.secret_string_wo_version


  copy_tags_to_snapshot = true

  publicly_accessible    = false
  db_subnet_group_name   = aws_db_subnet_group.private-eks.name
  vpc_security_group_ids = [data.aws_security_group.acl-allow-internal-tcp-eks.id]

  tags = {
    Environment = var.environment
    Project     = var.project
    Application = var.application
  }
}

resource "aws_db_parameter_group" "django-eks" {
  name   = "${var.project}-${var.application}-${var.environment}-${var.db-engine}"
  family = var.db-engine

  tags = {
    Environment = var.environment
    Project     = var.project
    Application = var.application
  }
}
