resource "aws_lb" "server" {
  name               = "${var.environment}-alb"
  internal           = false

security_groups = [
    data.aws_security_group.acl-allow-http-https-traffic.id,
    data.aws_security_group.acl-allow-all-outbound-traffic.id,
  ]

  load_balancer_type = "application"
  subnets = data.aws_subnets.public.ids

  enable_deletion_protection = true

 access_logs {
  bucket  = aws_s3_bucket.lb-logs.id
  prefix  = "${var.environment}-${var.application}-lb"
  enabled = true
}

  tags = {
    Environment = var.environment
    Project = var.project
    Application = var.application
  }
}

resource "aws_lb_target_group" "server" {
  name     = "${var.environment}-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.vpc.id

  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200-399"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  tags = {
    Environment = var.environment
    Project     = var.project
    Application = var.application
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.server.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.server.arn
    }
  }

# resource "aws_lb_listener" "https" {
#   load_balancer_arn = aws_lb.server.arn
#   port              = 443
#   protocol          = "HTTPS"
#   ssl_policy        = "ELBSecurityPolicy-2016-08"
#   certificate_arn   = aws_acm_certificate.ssl.arn

#   default_action {
#     type             = "forward"
#     target_group_arn = aws_lb_target_group.server.arn
#   }
# }