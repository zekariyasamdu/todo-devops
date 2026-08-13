resource "google_artifact_registry_repository" "training" {
  location      = var.region
  repository_id = var.repository_id
  format        = "DOCKER"
  description   = "Docker images for devops-todo for bothbackend and frontend"
}
