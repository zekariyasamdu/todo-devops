resource "google_sql_database_instance" "main" {
  name             = "devops-todo-db"
  database_version = "POSTGRES_16"
  region           = var.region

  settings {
    tier    = "db-f1-micro" # smallest tier — fine for a sandbox project
    edition = "ENTERPRISE"
  }

  # Prevents `tofu destroy` from accidentally nuking your data.
  # Flip to true when you actually want it deletable.
  deletion_protection = false
}

resource "google_sql_database" "app_db" {
  name     = var.db_name
  instance = google_sql_database_instance.main.name
}

resource "random_password" "db_password" {
  length  = 24
  special = false # keeps it URL/connection-string safe
}

resource "google_sql_user" "app_user" {
  name     = var.db_user
  instance = google_sql_database_instance.main.name
  password = random_password.db_password.result
}
