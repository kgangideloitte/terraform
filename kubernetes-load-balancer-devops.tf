resource "kubernetes_service" "python-ext-service-main" {
  metadata {
    name      = "python-ext-service"
    namespace = kubernetes_namespace.main.metadata[0].name
  }
  spec {
    selector = {
      App = kubernetes_deployment.python-ext-deployment-main.spec.0.template.0.metadata[0].labels.App
    }
    port {
      port        = 80
      target_port = 5000
    }

    type = "LoadBalancer"
  }
}


output "lb_status_main" {
  value = kubernetes_service.python-ext-service-main.status
}

resource "kubernetes_service" "python-ext-service-dev" {
  metadata {
    name      = "python-ext-service"
    namespace = kubernetes_namespace.dev.metadata[0].name
  }
  spec {
    selector = {
      App = kubernetes_deployment.python-ext-deployment-dev.spec.0.template.0.metadata[0].labels.App
    }
    port {
      port        = 80
      target_port = 5000
    }

    type = "LoadBalancer"
  }
}


output "lb_status_dev" {
  value = kubernetes_service.python-ext-service-dev.status
}