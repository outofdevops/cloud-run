// admin/vars.tf

variable "project_id" {
  type        = string
  description = "The GCP Project ID"
}

variable "region" {
  type        = string
  description = "The default region to use"
  default     = "europe-west1"
}

variable "db_password" {
  type        = string
  description = "The password for the sgs db instance"
}

variable "apis" {
  description = "List of apis to enable"
  type        = list(string)
  default = [
    "artifactregistry.googleapis.com",
    "sqladmin.googleapis.com",
    "run.googleapis.com",
    "compute.googleapis.com",
    "cloudresourcemanager.googleapis.com" //needed by terraform
  ]
}
