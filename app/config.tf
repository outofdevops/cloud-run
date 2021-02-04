// app/config.tf

terraform {
  required_providers {
    google = {
      version = "3.53.0"
      source  = "hashicorp/google"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}
