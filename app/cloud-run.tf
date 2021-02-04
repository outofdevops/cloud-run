// app/cloud-run.tf

locals {
  image_name = "europe-west1-docker.pkg.dev/${var.project_id}/docker-ar/simple-go-service:cloud-run"
}

resource "google_cloud_run_service" "sgs" {
  name     = "cloudrun-sgs"
  location = var.region
  template {
    spec {
      containers {
        image = local.image_name
        env {
          name  = "APP_DB_USERNAME"
          value = "sgs"
        }
        env {
          name  = "APP_DB_PASSWORD"
          value = var.db_password
        }
        env {
          name  = "APP_DB_NAME"
          value = "sgs"
        }
        env {
          name  = "APP_DB_HOST"
          value = "/cloudsql/${data.google_sql_database_instance.sgs.connection_name}"
        }
      }
    }

    metadata {
      annotations = {
        "autoscaling.knative.dev/maxScale"      = "1"
        "run.googleapis.com/cloudsql-instances" = data.google_sql_database_instance.sgs.connection_name
        "run.googleapis.com/client-name"        = "terraform"
      }
    }
  }
  autogenerate_revision_name = true
}

data "google_sql_database_instance" "sgs" {
  name = var.db_instance_name
}

data "google_iam_policy" "public" {
  binding {
    role = "roles/run.invoker"
    members = [
      "allUsers",
    ]
  }
}
# Enable public access on Cloud Run service
resource "google_cloud_run_service_iam_policy" "public" {
  location    = google_cloud_run_service.sgs.location
  project     = google_cloud_run_service.sgs.project
  service     = google_cloud_run_service.sgs.name
  policy_data = data.google_iam_policy.public.policy_data
}
