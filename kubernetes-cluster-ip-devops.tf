resource "kubernetes_service" "node-int-service-main" {
  metadata {
    name      = "events-internal"
    namespace = kubernetes_namespace.main.metadata[0].name
  }
  spec {
    selector = {
      App = kubernetes_deployment.node-int-deployment-main.spec.0.template.0.metadata[0].labels.App
    }
    port {
      port        = 80
      target_port = 8080
    }

    type = "ClusterIP"
  }
}


output "clusterip_status_main" {
  value = kubernetes_service.node-int-service-main.status
}

resource "kubernetes_service" "node-int-service-dev" {
  metadata {
    name      = "events-internal"
    namespace = kubernetes_namespace.dev.metadata[0].name
  }
  spec {
    selector = {
      App = kubernetes_deployment.node-int-deployment-dev.spec.0.template.0.metadata[0].labels.App
    }
    port {
      port        = 80
      target_port = 8080
    }

    type = "ClusterIP"
  }
}


output "clusterip_status_dev" {
  value = kubernetes_service.node-int-service-dev.status
}