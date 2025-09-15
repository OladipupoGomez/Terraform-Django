resource "kubernetes_service" "django_service" {
  metadata {
    name = "django-service"
    namespace = "deployments"
    labels = {
      app = "django-app"
    }
  }

  spec {
    selector = {
      app = "django-app"
    }
    type = "LoadBalancer"

    port {
      protocol    = "TCP"
      port        = 80
      target_port = 8000
    }
  }
}