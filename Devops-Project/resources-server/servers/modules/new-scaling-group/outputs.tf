output "iam_role_name" {
  value = aws_iam_role.server.name
}

output "asg_name" {
  value  = aws_autoscaling_group.servers.name
}