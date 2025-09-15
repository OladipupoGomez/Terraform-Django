module "dev-servers" {
  source = "./modules/new-scaling-group"

  providers = {
    aws = aws.us-east-1
  }

  environment  = var.environment
  application  = var.application
  project      = var.project
  instance-type = var.instance-type
  region-code   = var.region-code
  lb_target_group_arn = module.load-balancer.lb_target_group_arn
  aws-region = var.aws-region
}
output "asg_name" {
  value = module.dev-servers.asg_name
}

output "iam_role_name" {
  value = module.dev-servers.iam_role_name
}

module "load-balancer" {
  source = "./modules/new-lb"

  providers = {
    aws = aws.us-east-1
  }

  environment  = var.environment
  application  = var.application
  project      = var.project
  region-code  = var.region-code
  Django-port  = var.Django-port
}

module "storage-bucket" {
  source = "./modules/new-s3"

   providers = {
    aws = aws.us-east-1
  }
  
  environment  = var.environment
  application  = var.application
  project      = var.project
  region-code  = var.region-code
  iam_role_name = module.dev-servers.iam_role_name
}

output "s3_bucket_name" {
  value = module.storage-bucket.s3_bucket_name
}
