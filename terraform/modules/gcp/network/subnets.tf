
# Public
resource "google_compute_subnetwork" "public" {
  count = var.subnet_count

  name          = "public-subnet-${count.index}"
  ip_cidr_range = cidrsubnet(var.cidr_block, 3, count.index)
  network       = google_compute_network.main.self_link
  region        = var.region
}

# Private
resource "google_compute_subnetwork" "private" {
  count = var.subnet_count

  name                     = "private-subnet-${count.index}"
  ip_cidr_range            = cidrsubnet(var.cidr_block, 3, count.index + var.subnet_count)
  network                  = google_compute_network.main.self_link
  region                   = var.region
  private_ip_google_access = true
}
