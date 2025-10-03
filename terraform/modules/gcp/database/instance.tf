
# Replica database instance (the Subscriber)
resource "google_sql_database_instance" "replica_db" {
  name             = "postgresql-replica-db-instance"
  database_version = "POSTGRES_17"
  region           = var.region

  settings {
    tier    = "db-f1-micro"
    edition = "ENTERPRISE"

    ip_configuration {
      ipv4_enabled    = false
      private_network = var.vpc_self_link
    }
  }

  deletion_protection = false
  root_password       = var.root_password
}

# resource "google_sql_database" "db" {
#   project  = var.project_id
#   instance = google_sql_database_instance.replica_db.name
#   name     = var.db_name
# }

# resource "null_resource" "create_subscription" {
#   depends_on = [google_sql_database_instance.replica_db]

#   provisioner "local-exec" {
#     command = <<EOT
#     PGPASSWORD=${google_secret_manager_secret_version.db_password_secret_version.secret_data} \
#     psql -h ${google_sql_database_instance.replica_db.ip_address[0].ip_address} -U ${var.replication_user} -d ${var.db_name} -c "
#       CREATE SUBSCRIPTION cars_sub
#       CONNECTION 'host=${var.rds_instance_address} port=5432 user=${var.replication_user}
#       password=${var.replication_user_password} dbname=${var.db_name}'
#       PUBLICATION cars_pub;
#     "
#     EOT

#     environment = {
#       PGPASSWORD = google_secret_manager_secret_version.db_password_secret_version.secret_data
#     }
#   }
# }
