// app/vars.tf

variable "project_id" {
  type        = string
  description = "The GCP Project ID"
}

variable "db_password" {
  type        = string
  description = "The password for the sgs db instance"
}

variable "region" {
  type        = string
  description = "The default region to use"
  default     = "europe-west1"
}

variable "db_instance_name" {
  description = "The name of the database instance"
  type        = string
}
