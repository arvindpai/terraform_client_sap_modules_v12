# Creation of different firewall rules

resource "google_compute_firewall" "ssh" {
  name    = "${var.network}-firewall-ssh"
  project = "${var.project_id}"
  network = "${google_compute_network.gcp_network.name}"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  target_tags   = ["${var.network}-firewall-ssh"]
  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "http" {
  name    = "${var.network}-firewall-http"
  project = "${var.project_id}"
  network = "${google_compute_network.gcp_network.name}"

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  target_tags   = ["${var.network}-firewall-http"]
  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "https" {
  name    = "${var.network}-firewall-https"
  project = "${var.project_id}"
  network = "${google_compute_network.gcp_network.name}"

  allow {
    protocol = "tcp"
    ports    = ["443"]
  }

  target_tags   = ["${var.network}-firewall-https"]
  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "icmp" {
  project = "${var.project_id}"
  name    = "${var.network}-firewall-icmp"
  network = "${google_compute_network.gcp_network.name}"

  allow {
    protocol = "icmp"
  }

  target_tags   = ["${var.network}-firewall-icmp"]
  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "internal_access" {
  project   = "${var.project_id}"
  name      = "${var.network}-firewall-internal-access"
  network   = "${google_compute_network.gcp_network.name}"
  direction = "INGRESS"
  allow {
    protocol = "all"
    ports    = []
  }
}
