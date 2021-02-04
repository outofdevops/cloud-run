// admin/db.tf

resource "random_id" "db_name_suffix" {
  byte_length = 4
}

resource "google_sql_database_instance" "sgs" {
  name                = "sgs-${random_id.db_name_suffix.hex}"
  database_version    = "POSTGRES_12"
  deletion_protection = false #Used for demonstration purposes remove this in real scenarios
  region              = var.region

  settings {
    tier              = "db-f1-micro"
    availability_type = "ZONAL"

    backup_configuration {
      enabled            = false
      binary_log_enabled = false
    }

    ip_configuration {
      ipv4_enabled = true
    }

  }

  depends_on = [
    google_project_service.apis["sqladmin.googleapis.com"],
  ]
}

resource "google_sql_database" "sgs" {
  name     = "sgs"
  instance = google_sql_database_instance.sgs.name

  depends_on = [
    google_sql_database_instance.sgs,
  ]
}

resource "google_sql_user" "users" {
  name            = "sgs"
  instance        = google_sql_database_instance.sgs.name
  password        = var.db_password
  deletion_policy = "ABANDON"
}
