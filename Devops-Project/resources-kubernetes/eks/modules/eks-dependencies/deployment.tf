resource "kubernetes_deployment" "django" {
  metadata {
    name      = "django-deployment"
    namespace = "deployments"
    labels = {
      app = "django-app"
    }
  }
  spec {
    replicas = 1
    strategy {
    type = "RollingUpdate"
    rolling_update {
      max_surge       = 1
      max_unavailable = 0
    }
  }
    selector {
      match_labels = {
        app = "django-app"
      }
    }
    template {
      metadata {
        labels = {
          app = "django-app"
        }
      }
      spec {
        container {
          name  = "django"
          image = "${data.aws_ecr_repository.django-app.repository_url}:latest"
          port {
            container_port = 8000
          }
         env_from {
            secret_ref {
              name = kubernetes_secret.django.metadata[0].name
            }
         }
          resources {
            requests = {
              cpu    = "250m"
              memory = "512Mi"
            }
            limits = {
              cpu    = "500m"
              memory = "1Gi"
            }
          }
        }
      }
    }
  }
}