resource "kubernetes_namespace" "main" {
  metadata {
    name = "main branch"
  }
}

resource "kubernetes_namespace" "dev" {
  metadata {
    name = "dev branch"
  }
}
