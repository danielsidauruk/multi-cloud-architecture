
resource "google_project_iam_member" "iap_tunnel_access" {
  project = var.project_id
  role    = "roles/iap.tunnelResourceAccessor"
  member  = "serviceAccount:${google_service_account.vm_sa.email}"
}

resource "google_service_account" "vm_sa" {
  account_id   = "gcp-vm-sa"
  display_name = "VM Service Account"
}
