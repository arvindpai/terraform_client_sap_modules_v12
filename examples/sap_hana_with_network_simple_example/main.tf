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

module "gcp_sap_hana_with_network" {
  source                     = "../../modules/sap_hana_with_network"
  subnetwork                 = "${var.subnetwork}"
  linux_image_family         = "${var.linux_image_family}"
  linux_image_project        = "${var.linux_image_project}"
  instance_name              = "${var.instance_name}"
  instance_type              = "${var.instance_type}"
  project_id                 = "${var.project_id}"
  region                     = "${var.region}"
  zone                       = "${var.zone}"
  service_account_email      = "${var.service_account_email}"
  boot_disk_type             = "${var.boot_disk_type}"
  boot_disk_size             = "${var.boot_disk_size}"
  autodelete_disk            = "true"
  pd_ssd_size                = "${var.pd_ssd_size}"
  pd_hdd_size                = "${var.pd_hdd_size}"
  disk_name_0                = "${var.disk_name_0}"
  disk_name_1                = "${var.disk_name_1}"
  sap_hana_deployment_bucket = "${var.sap_hana_deployment_bucket}"
  sap_deployment_debug       = "false"
  post_deployment_script     = "${var.post_deployment_script}"
  sap_hana_sid               = "${var.sap_hana_sid}"
  sap_hana_instance_number   = "${var.sap_hana_instance_number}"
  sap_hana_sidadm_password   = "${var.sap_hana_sidadm_password}"
  sap_hana_system_password   = "${var.sap_hana_system_password}"
  network_tags               = "${var.network_tags}"
  sap_hana_sidadm_uid        = 900
  sap_hana_sapsys_gid        = 900
  address_name               = "${var.address_name}"
  priority                   = "${var.priority}"
  route_destination_range    = "${var.route_destination_range}"
  route_tags                 = "${var.route_tags}"
  ip_cidr_range              = "${var.ip_cidr_range}"
  description                = "${var.description}"
  network                    = "${var.network}"
  public_ip                  = "${var.public_ip}"
}
