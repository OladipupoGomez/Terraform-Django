data "aws_ami" "ec2-ami-image" {
  most_recent = true

  filter {
    name = "architecture"
    values = ["x86_64"]
  }

  filter {
    name = "name"
    values = ["ubuntu/images/*ssd*/ubuntu-noble-24.04-*"]
  }

  filter {
    name = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["amazon"]
}

resource "aws_placement_group" "development-servers" {
  name     = "development"
  strategy = "spread"
}

  resource "aws_launch_template" "servers" {
  name_prefix     = "${var.environment}-asg-configuration"

  block_device_mappings {
    device_name = "/dev/sda1" 
      ebs {
        volume_size           = 30            
        volume_type           = "gp3"      
        delete_on_termination = false
      }
    }

block_device_mappings {
    device_name = "/dev/sdf"

    ebs {
      volume_size           = 20
      volume_type           = "gp3"
      delete_on_termination = false
    }
  }

  capacity_reservation_specification {
    capacity_reservation_preference = "none"
  }

#current instance-type does not support this,chnage instance-type and uncomment to use.
  # cpu_options {
  #   core_count       = 4
  #   threads_per_core = 2
  # }

  disable_api_stop        = false
  disable_api_termination = false

  ebs_optimized = true

  iam_instance_profile {
    name = aws_iam_instance_profile.server.id
  }

  image_id = data.aws_ami.ec2-ami-image.id

  instance_initiated_shutdown_behavior = "stop"

  instance_type = var.instance-type

  key_name = aws_key_pair.ssh.id

  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required"
    http_put_response_hop_limit = 1
    instance_metadata_tags      = "enabled"
  }

  monitoring {
    enabled = true
  }

  network_interfaces {
    associate_public_ip_address = true
    security_groups = [data.aws_security_group.acl-allow-internal-ssh-traffic.id,
    data.aws_security_group.acl-allow-all-outbound-traffic.id,
    data.aws_security_group.acl-allow-alb-traffic.id]
  }

  placement {
    availability_zone = var.aws-region
  }

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "django-${var.application}-${var.environment}"
      Environment = var.environment
      Project = var.project
    }
  }

 user_data = base64encode(templatefile("${path.module}/templates/user-data.tpl", { instance_name = "${local.hostname-prefix}.${var.region-code}",
    installdir = "/tmp/aws.XXXXXXXX"
  }))
  }

resource "aws_autoscaling_attachment" "servers" {
  autoscaling_group_name = aws_autoscaling_group.servers.id
  lb_target_group_arn    = var.lb_target_group_arn
}

resource "aws_autoscaling_group" "servers" {
  name                      = "${var.environment}-scaling-group"
  max_size                  = 2
  min_size                  = 1
  desired_capacity          = 1
  health_check_grace_period = 300
  health_check_type         = "ELB"
  force_delete              = true
  placement_group           = aws_placement_group.development-servers.id
  vpc_zone_identifier = data.aws_subnets.public.ids
  launch_template {
    id      = aws_launch_template.servers.id
    version = "$Latest"
  }

#use if you want instances to be recreated when a terraform apply is ran Note the new instance would the updated changes
 instance_refresh {
    strategy = "Rolling"
    triggers = ["launch_template"]
  }

  tag {
    key   = "Environment"
    value = var.environment
    propagate_at_launch = true
  }


  tag {
      key   = "Project"
      value = var.project
      propagate_at_launch = true
    }

  tag {
      key   = "Application"
      value = var.application
      propagate_at_launch = true
    }

lifecycle {
    create_before_destroy = true
    ignore_changes        = [desired_capacity]
  }
}