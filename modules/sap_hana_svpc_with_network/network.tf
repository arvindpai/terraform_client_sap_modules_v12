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

# Creation of VPC Network
resource "google_compute_network" "gcp_network" {
  name                    = "${var.network}"
  auto_create_subnetworks = "${var.auto_create_subnetworks}"
  project                 = "${var.host_project_id}"
  description             = "${var.description}"
  routing_mode            = "REGIONAL"
}

# Creation of Subnetwork
resource "google_compute_subnetwork" "gcp_subnetwork" {
  name          = "${var.subnetwork}"
  project       = "${var.host_project_id}"
  network       = "${google_compute_network.gcp_network.self_link}"
  region        = "${var.region}"
  ip_cidr_range = "${var.ip_cidr_range}"
  depends_on    = [google_compute_network.gcp_network]
  #private_ip_google_access = "true"
}
