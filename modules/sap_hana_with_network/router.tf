# Creation of Router
resource "google_compute_router" "gcp_router" {
  project = "${var.project_id}"
  name    = "router"
  region  = google_compute_subnetwork.gcp_subnetwork.region
  network = google_compute_network.gcp_network.self_link
  bgp {
    asn = 64514
  }
}

# Creation of NAT
resource "google_compute_router_nat" "gcp_nat" {
  project                            = "${var.project_id}"
  name                               = "nat-1"
  router                             = google_compute_router.gcp_router.name
  region                             = "${var.region}"
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
}
