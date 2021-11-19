resource "kubernetes_deployment" "node-ext-deployment-main" {
  metadata {
    name = "events-external"
    labels = {
      App = "events-external"
    }
    namespace = kubernetes_namespace.main.metadata[0].name
  }

  spec {
    replicas                  = 4
    progress_deadline_seconds = 60
    selector {
      match_labels = {
        App = "events-external"
      }
    }
    template {
      metadata {
        labels = {
          App = "events-external"
        }
      }
      spec {
        container {
          image = "kcgjr/sample-external:v0.1"
          name  = "events-external"
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
              memory = "256Mi"
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

resource "kubernetes_deployment" "node-ext-deployment-dev" {
  metadata {
    name = "events-external"
    labels = {
      App = "events-external"
    }
    namespace = kubernetes_namespace.dev.metadata[0].name
  }

  spec {
    replicas                  = 2
    progress_deadline_seconds = 60
    selector {
      match_labels = {
        App = "events-external"
      }
    }
    template {
      metadata {
        labels = {
          App = "events-external"
        }
      }
      spec {
        container {
          image = "kcgjr/sample-external:v0.1"
          name  = "events-external"
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
              memory = "256Mi"
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
