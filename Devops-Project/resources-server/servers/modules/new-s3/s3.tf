resource "aws_s3_bucket" "server_s3" {
  bucket = "${var.environment}-${var.application}-static-files"

  tags = {
    Environment = var.environment
    Project    = var.project
    Application = var.application
  }
}
