data "aws_ecr_repository" "django-app" {
 name = "${var.environment}-django-ecr"
}