resource "kubernetes_horizontal_pod_autoscaler_v2" "django_hpa" {
  metadata {
    name = "django-hpa"
    namespace = "deployments"
  }
  spec {
    scale_target_ref {
      api_version = "apps/v1"
      kind        = "Deployment"
      name = "django-deployment"
    }

    min_replicas = 1
    max_replicas = 3

    metric {
      type = "Resource"
      resource {
        name = "cpu"
        target {
          type               = "Utilization"
          average_utilization = 70
        }
      }
    }
  }
}
