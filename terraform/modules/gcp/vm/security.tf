
resource "google_compute_firewall" "allow_iap_icmp" {
  name    = "allow-iap-and-icmp"
  network = var.vpc_name

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  allow {
    protocol = "icmp"
  }

  source_ranges = [
    "35.235.240.0/20",
    var.cidr_block,
  ]

  target_tags = ["iap-icmp-allowed"]
}
