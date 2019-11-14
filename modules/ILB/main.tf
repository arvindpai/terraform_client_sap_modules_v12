/**
 * Copyright 2018 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */


data "google_compute_instance" "ilb-instance-1" {
  project = "${var.project_id}"
  name    = "ilb-1"
  zone    = "${var.region_zone}"
}

data "google_compute_instance" "ilb-instance-2" {
  project = "${var.project_id}"
  name    = "ilb-2"
  zone    = "${var.region_zone_2}"
}

data "google_compute_subnetwork" "subnetwork" {
  name    = "${var.subnetwork}"
  project = "${var.project_id}"
  region  = "${var.region}"
}


data "google_compute_network" "network" {
  name    = "${var.network}"
  project = "${var.project_id}"
}

resource "google_compute_instance_group" "us-ig1" {
  project = "${var.project_id}"
  name    = "us-ig1"

  instances = [
    "${data.google_compute_instance.ilb-instance-1.self_link}",
  ]

  zone = "${var.region_zone}"
}

resource "google_compute_instance_group" "us-ig2" {
  project = "${var.project_id}"
  name    = "us-ig2"

  instances = [
    "${data.google_compute_instance.ilb-instance-2.self_link}",
  ]

  zone = "${var.region_zone_2}"
}

resource "google_compute_health_check" "my-tcp-health-check" {
  project = "${var.project_id}"
  name    = "my-tcp-health-check"

  tcp_health_check {
    port = "80"
  }
}

resource "google_compute_region_backend_service" "my-int-lb" {
  project       = "${var.project_id}"
  name          = "my-int-lb"
  health_checks = ["${google_compute_health_check.my-tcp-health-check.self_link}"]
  region        = "${var.region}"

  backend {
    group = "${google_compute_instance_group.us-ig1.self_link}"
  }

  backend {
    group = "${google_compute_instance_group.us-ig2.self_link}"
  }

}

resource "google_compute_forwarding_rule" "my-int-lb-forwarding-rule" {
  project               = "${var.project_id}"
  name                  = "my-int-lb-forwarding-rule"
  region                = "${var.region}"
  load_balancing_scheme = "INTERNAL"
  ports                 = ["80"]
  network               = "${data.google_compute_network.network.self_link}"
  subnetwork            = "${data.google_compute_subnetwork.subnetwork.self_link}"
  backend_service       = "${google_compute_region_backend_service.my-int-lb.self_link}"
}

resource "google_compute_firewall" "allow-internal-lb" {
  project = "${var.project_id}"
  name    = "allow-internal-lb"
  network = "${data.google_compute_network.network.name}"

  allow {
    protocol = "tcp"
    ports    = ["80", "443"]
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["int-lb"]
}

resource "google_compute_firewall" "allow-health-check" {
  project = "${var.project_id}"
  name    = "allow-health-check"
  network = "${data.google_compute_network.network.name}"

  allow {
    protocol = "tcp"
  }

  source_ranges = ["0.0.0.0/0"]
  target_tags   = ["int-lb"]
}
