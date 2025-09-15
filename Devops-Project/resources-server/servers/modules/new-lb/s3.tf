resource "aws_s3_bucket" "lb-logs" {
  bucket = "${var.environment}-${var.application}-lb-logs"

  tags = {
    Environment = var.environment
    Project     = var.project
    Application = var.application
  }
}