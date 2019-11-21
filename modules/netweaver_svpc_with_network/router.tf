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


# Creation of Router
resource "google_compute_router" "gcp_router" {
  project = "${var.host_project_id}"
  name    = "router"
  region  = google_compute_subnetwork.gcp_subnetwork.region
  network = google_compute_network.gcp_network.self_link
  bgp {
    asn = 64514
  }
}

# Creation of NAT
resource "google_compute_router_nat" "gcp_nat" {
  project                            = "${var.host_project_id}"
  name                               = "nat-1"
  router                             = google_compute_router.gcp_router.name
  region                             = "${var.region}"
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
}
