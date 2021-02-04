// admin/artifact_registry.tf

resource "google_artifact_registry_repository" "docker_ar" {
  provider = google-beta

  location      = var.region
  repository_id = "docker-ar"
  description   = "Docker repository"
  format        = "DOCKER"

  depends_on = [
    google_project_service.apis["artifactregistry.googleapis.com"],
  ]
}
