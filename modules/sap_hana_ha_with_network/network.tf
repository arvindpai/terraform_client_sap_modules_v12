# Creation of VPC Network
resource "google_compute_network" "gcp_network" {
  name                    = "${var.network}"
  auto_create_subnetworks = "${var.auto_create_subnetworks}"
  project                 = "${var.project_id}"
  description             = "${var.description}"
  routing_mode            = "REGIONAL"
}

# Creation of Subnetwork
resource "google_compute_subnetwork" "gcp_subnetwork" {
  name                     = "${var.subnetwork}"
  project                  = "${var.project_id}"
  network                  = "${google_compute_network.gcp_network.self_link}"
  region                   = "${var.region}"
  ip_cidr_range            = "${var.ip_cidr_range}"
  private_ip_google_access = "true"
  enable_flow_logs         = "false"
  secondary_ip_range {
    range_name    = "${var.sap_vip_secondary_range}"
    ip_cidr_range = "${var.secondary_ip_cidr_range}"
  }
}
