
data "google_compute_image" "ubuntu" {
  family  = "ubuntu-2204-lts"
  project = "ubuntu-os-cloud"
}

data "google_compute_zones" "available" {
  project = var.project_id
  region  = var.region
}

locals {
  image  = data.google_compute_image.ubuntu.name
  zone   = data.google_compute_zones.available.names[0]
  subnet = var.public_subnet_ids[0]
}

resource "google_compute_instance" "vm" {
  name                      = "vm-instance"
  machine_type              = "e2-small"
  zone                      = local.zone
  tags                      = ["iap-icmp-allowed"]
  allow_stopping_for_update = true

  boot_disk {
    initialize_params {
      image = local.image
    }
  }

  network_interface {
    subnetwork = local.subnet
    network    = var.vpc_name

    access_config {}
  }

  service_account {
    email  = google_service_account.vm_sa.email
    scopes = ["cloud-platform"]
  }
}
