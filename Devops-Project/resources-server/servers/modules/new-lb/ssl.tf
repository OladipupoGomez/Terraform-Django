# resource "aws_acm_certificate" "ssl" {
#   validation_method = "DNS"
#   domain_name       = ""

#   tags = {
#     EnvironmentCode = var.environment
#     ProjectCode     = var.project
#     ApplicationCode = var.application
#   }

#   lifecycle {
#     create_before_destroy = true
#   }
# }

# resource "aws_acm_certificate_validation" "ssl" {
#   certificate_arn         = aws_acm_certificate.ssl.arn
#   validation_record_fqdns = [for record in cloudflare_dns_record.dcv : record.name]
# }
