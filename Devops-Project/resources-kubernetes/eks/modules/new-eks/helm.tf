resource "helm_release" "metrics_server" {
  name       = "metrics-server"
  repository = "https://kubernetes-sigs.github.io/metrics-server/"
  chart      = "metrics-server"
  namespace  = "kube-system"
}

# resource "helm_release" "aws_fluentbit" {
#   name       = "aws-for-fluent-bit"
#   namespace  = "kube-system"
#   repository = "https://aws.github.io/eks-charts"
#   chart      = "aws-for-fluent-bit"
#   version    = "0.1.35" # Use the latest stable version
#   # wait       = false

#   values = [
#     yamlencode({
#       serviceAccount = {
#         create      = true
#         name        = "fluentbit"
#         annotations = {
#           "eks.amazonaws.com/role-arn" = aws_iam_role.fluentbit_irsa.arn
#         }
#       }

#       cloudWatch = {
#         enabled           = true
#         region            = var.aws-region
#         logGroupName      = "/aws/containerinsights/django-app"
#         logStreamPrefix   = "kube"
#         autoCreateGroup   = true
#         autoCreateStream  = true
#       }
      
#       # Additional configurations for the inputs
#       inputs = {
#         tail = {
#           enabled = true
#           path = "/var/log/containers/*.log"
#           parsers = ["json", "docker"]
#           tag = "kube.*"
#         }
#       }

#       # Filters to add Kubernetes metadata
#       filters = {
#         kubernetes = {
#           enabled = true
#           match = "kube.*"
#         }
#       }
#     })
#   ]
# }

# resource "helm_release" "prometheus" {
#   name       = "prometheus"
#   repository = "https://prometheus-community.github.io/helm-charts"
#   chart      = "kube-prometheus-stack"
#   namespace  = "monitoring"
#   version = "34.0"

#   values = [
#     yamlencode({
#       prometheus = { 
#         prometheusSpec = { 
#           serviceMonitorSelectorNilUsesHelmValues = false
#         }
#       }
#       grafana = {
#         adminUser = var.grafana-username
#         adminPassword = var.grafana-password
#         service = { type = "LoadBalancer" }
#       }
#     })
#   ]
# }