resource "kubernetes_service" "python-ext-service" {
  metadata {
    name      = "python-ext-service"
    namespace = kubernetes_namespace.n.metadata[0].name
  }
  spec {
    selector = {
      App = kubernetes_deployment.python-ext-deployment.spec.0.template.0.metadata[0].labels.App
    }
    port {
      port        = 80
      target_port = 5000
    }

    type = "LoadBalancer"
  }
}


output "lb_status" {
  value = kubernetes_service.python-ext-service.status
}
