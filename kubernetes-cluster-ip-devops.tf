resource "kubernetes_service" "node-int-service" {
  metadata {
    name      = "events-internal"
    namespace = kubernetes_namespace.n.metadata[0].name
  }
  spec {
    selector = {
      App = kubernetes_deployment.node-int-deployment.spec.0.template.0.metadata[0].labels.App
    }
    port {
      port        = 80
      target_port = 8080
    }

    type = "ClusterIP"
  }
}


output "clusterip_status" {
  value = kubernetes_service.node-int-service.status
}
