// app/output.tf

output "service_url" {
  value = google_cloud_run_service.sgs.status[0].url
}
