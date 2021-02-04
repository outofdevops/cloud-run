// admin/output.tf

output "db_name" {
  value = google_sql_database_instance.sgs.name
}
