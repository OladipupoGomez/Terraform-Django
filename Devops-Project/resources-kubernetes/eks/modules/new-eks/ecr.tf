resource "aws_ecr_repository" "django-ecr" {
  name                 = "${var.environment}-django-ecr"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
tags = {
    Name = "${var.environment}-django-ecr"
    Environment = var.environment
    Application = var.application 
  }
}