resource "ovh_cloud_project_database" "postgres" {
  service_name = var.service_name
  engine       = "postgresql"
  flavor       = var.flavor

  dynamic "nodes" {
    for_each = toset(range(var.node_count))
    content {
      network_id = var.network_id
      region     = var.region
      subnet_id  = var.subnet_id
    }
  }

  plan        = var.plan
  version     = var.postgres_version
  description = var.description
  disk_size   = var.disk_size

  ip_restrictions {
    ip          = "0.0.0.0/0"
    description = ""
  }
}
