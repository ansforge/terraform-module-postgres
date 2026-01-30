output "database_uri" {
  value = ovh_cloud_project_database.postgres.endpoints.0.uri
}

output "admin_username" {
  value = ovh_cloud_project_database_postgresql_user.admin_user.name
}

output "admin_password" {
  value     = ovh_cloud_project_database_postgresql_user.admin_user.password
  sensitive = true
}
