resource "kubernetes_deployment" "python-ext-deployment" {
  metadata {
    name = "events-external-py"
    labels = {
      App = "events-external-py"
    }
    namespace = kubernetes_namespace.n.metadata[0].name
  }

  spec {
    replicas                  = 4
    progress_deadline_seconds = 60
    selector {
      match_labels = {
        App = "events-external-py"
      }
    }
    template {
      metadata {
        labels = {
          App = "events-external-py"
        }
      }
      spec {
        container {
          image = "kcgjr/pythonclient:v0.1"
          name  = "events-external-py"
          image_pull_policy = "Always"

          port {
            container_port = 80
          }

          env {
            name = "SERVER"
            value = "http://events-internal"
          }

          env {
            name = "PORT"
            value = "5000"
          }

          resources {
            limits = {
              cpu    = "0.2"
              memory = "2562Mi"
            }
            requests = {
              cpu    = "0.1"
              memory = "50Mi"
            }
          }
        }
      }
    }
  }
}
