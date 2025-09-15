output "rds_db_name" {
  value = data.aws_db_instance.rds-eks.db_name
  sensitive = true
}

output "rds_host" {
  value = data.aws_db_instance.rds-eks.address
  sensitive = true
}

output "rds_port" {
  value = data.aws_db_instance.rds-eks.port
  sensitive = true
}

output "rds_password" {
  value = data.aws_secretsmanager_secret_version.rds-eks-password.secret_string
  sensitive = true
}
