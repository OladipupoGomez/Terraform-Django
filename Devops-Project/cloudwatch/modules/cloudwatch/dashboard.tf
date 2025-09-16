resource "aws_cloudwatch_dashboard" "dashboard" {
  dashboard_name = "${var.environment}-${var.application}-dashboard"

  dashboard_body = jsonencode({
    widgets = [
      {
        type   = "metric"
        x      = 0
        y      = 0
        width  = 12
        height = 6

        properties = {
          metrics = [
            [
              "AWS/EC2",
              "CPUUtilization",
              "AutoScalingGroupName",
              "${data.tfe_outputs.devops-servers-development.values.asg_name}"
            ]
          ]
          period = 300
          stat   = "Average"
          region = "us-east-1"
          title  = "${data.tfe_outputs.devops-servers-development.values.asg_name} - CPU Utilization"
        }
      },
      {
        type   = "metric"
        x      = 0
        y      = 7
        width  = 12
        height = 6

        properties = {
          metrics = [
            [
              "AWS/EC2",
              "NetworkIn",
              "AutoScalingGroupName",
              "${data.tfe_outputs.devops-servers-development.values.asg_name}"
            ]
          ]
          period = 300
          stat   = "Average"
          region = "us-east-1"
          title  = "${data.tfe_outputs.devops-servers-development.values.asg_name} - NetworkIn"
        }
      },
      {
        type   = "text"
        x      = 0
        y      = 14
        width  = 12
        height = 3

        properties = {
          markdown = "${var.environment}-dashboard"
        }
      }
    ]
  })
}