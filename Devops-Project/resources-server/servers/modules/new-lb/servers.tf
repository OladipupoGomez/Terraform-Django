data "aws_instances" "application-servers" {
  instance_tags = {
    Environment = var.environment
    Project     = var.project
    Application = var.application
  }
}
