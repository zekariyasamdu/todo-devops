locals {
  backend_image  = "${var.region}-docker.pkg.dev/${var.project_id}/${var.repository_id}/backend:${var.image_tag}"
  frontend_image = "${var.region}-docker.pkg.dev/${var.project_id}/${var.repository_id}/frontend:${var.image_tag}"
}

resource "google_cloud_run_v2_service" "backend" {
  name                = "devops-todo-backend"
  location            = var.region
  deletion_protection = false
  ingress             = "INGRESS_TRAFFIC_ALL"

  template {
    containers {
      image = local.backend_image
      ports {
        container_port = 3000
      }

      env {
        name  = "DB_HOST"
        value = "/cloudsql/${google_sql_database_instance.main.connection_name}"
      }
      env {
        name  = "DB_NAME"
        value = var.db_name
      }
      env {
        name  = "DB_USERNAME"
        value = var.db_user
      }
      env {
        name = "DB_PASSWORD"
        value_source {
          secret_key_ref {
            secret  = google_secret_manager_secret.db_password.secret_id
            version = "latest"
          }
        }
      }

      volume_mounts {
        name       = "cloudsql"
        mount_path = "/cloudsql"
      }
    }

    volumes {
      name = "cloudsql"
      cloud_sql_instance {
        instances = [google_sql_database_instance.main.connection_name]
      }
    }
  }

  depends_on = [
    google_artifact_registry_repository.training,
    google_sql_database_instance.main,
    google_secret_manager_secret_iam_member.backend_secret_access,
  ]
}

resource "google_cloud_run_v2_service" "frontend" {
  name                = "devops-todo-frontend"
  location            = var.region
  ingress             = "INGRESS_TRAFFIC_ALL"
  deletion_protection = false

  template {
    containers {
      image = local.frontend_image

      ports {
        container_port = 80
      }
    }
  }

  depends_on = [google_artifact_registry_repository.training]
}

# Cloud Run services are private by default — this makes them
# reachable over the public internet without needing IAM auth per-request.
resource "google_cloud_run_v2_service_iam_member" "backend_public" {
  location = google_cloud_run_v2_service.backend.location
  name     = google_cloud_run_v2_service.backend.name
  role     = "roles/run.invoker"
  member   = "allUsers"
}

resource "google_cloud_run_v2_service_iam_member" "frontend_public" {
  location = google_cloud_run_v2_service.frontend.location
  name     = google_cloud_run_v2_service.frontend.name
  role     = "roles/run.invoker"
  member   = "allUsers"
}
