// admin/config.tf

terraform {
  required_providers {
    google = {
      version = "3.53.0"
      source  = "hashicorp/google"
    }
    google-beta = {
      version = "3.53.0"
      source  = "hashicorp/google-beta"
    }
    random = {
      version = "3.0.1"
      source  = "hashicorp/random"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}

provider "google-beta" {
  project = var.project_id
  region  = var.region
}
