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

variable "project_id" {
  description = "The ID of the project in which the resources will be deployed."
}

variable "host_project_id" {
  description = "The ID of the project in which the network resources will be deployed."
}
variable "zone" {
  description = "The zone that the instance should be created in."
}

variable "region" {
  description = "Region to deploy the resources. Should be in the same region as the zone."
}

variable "instance_name" {
  description = "A unique name for the resource, required by GCE. Changing this forces a new resource to be created."
}

variable "instance_type" {
  description = "The GCE instance/machine type."
}

# SAP Hana Variables
variable "linux_image_family" {
  description = "GCE image family."
}

variable "linux_image_project" {
  description = "Project name containing the linux image."
}

variable "autodelete_disk" {
  description = "Whether the disk will be auto-deleted when the instance is deleted."
  default     = "false"
}

variable "disk_name_0" {
  description = "Name of first disk."

}

variable "disk_name_1" {
  description = "Name of second disk."

}

variable "disk_type_0" {
  description = "The GCE data disk type. May be set to pd-ssd."
  default     = "pd-ssd"
}

variable "disk_type_1" {
  description = "The GCE data disk type. May be set to pd-standard (for PD HDD)."
  default     = "pd-standard"
}

variable "boot_disk_size" {
  description = "Root disk size in GB."
}

variable "boot_disk_type" {
  description = "The GCE boot disk type. May be set to pd-standard (for PD HDD) or pd-ssd."
}

variable "pd_ssd_size" {
  description = "Persistent disk size in GB."
  default     = ""
}

variable "pd_hdd_size" {
  description = "Persistent disk size in GB."
  default     = ""
}

variable "device_name_pd_ssd" {
  description = "device name for ssd persistant disk"
  default     = "pdssd"
}

variable "device_name_pd_hdd" {
  description = "device name for standard persistant disk"
  default     = "backup"
}

variable "service_account_email" {
  description = "Email of service account to attach to the instance."
}


variable "network_tags" {
  type        = "list"
  description = "List of network tags to attach to the instance."
}

variable "address_name" {
  description = "Name of static IP adress to add to the instance's access config."
}

variable "sap_hana_deployment_bucket" {
  description = "SAP hana deployment bucket."
}

variable "sap_deployment_debug" {
  description = "Debug flag for SAP HANA deployment."
  default     = "false"
}

variable "post_deployment_script" {
  description = "SAP HANA post deployment script. Must be a gs:// or https:// link to the script."
  default     = ""
}

variable "sap_hana_sid" {
  description = "SAP HANA System Identifier. When using the SID to enter a user session, like this for example, `su - [SID]adm`, make sure that [SID] is in lower case."
}

variable "sap_hana_instance_number" {
  description = "SAP HANA instance number"
}

variable "sap_hana_sidadm_password" {
  description = "SAP HANA System Identifier Admin password"
}

variable "sap_hana_system_password" {
  description = "SAP HANA system password"
}

variable "sap_hana_sidadm_uid" {
  description = "SAP HANA System Identifier Admin UID"
  default     = 900
}

variable "sap_hana_sapsys_gid" {
  description = "SAP HANA SAP System GID"
  default     = 900
}

# Route variables
variable "route_destination_range" {
  description = "Enter the range for the route destination"
}

variable "priority" {
  description = "priority of the route"
}

variable "route_tags" {
  description = "tags assigned to routes"
}

# Network Variables
variable "network" {
  description = "name of the vpc network"
  default     = ""
}

variable "description" {
  description = "The description of VPC network."
}

variable "auto_create_subnetworks" {
  description = "Auto creation of subnetwork's whether want it false or true"
  default     = "false"
}

#Subnetwork variables

variable "subnetwork" {
  description = "The name or self_link of the subnetwork where the instance will be deployed. The subnetwork must exist in the same region this instance will be created in."
  default     = ""
}

variable "ip_cidr_range" {
  description = "ip cidr range for subnetwork"
}

variable "public_ip" {
  description = "Determines whether a public IP address is added to your VM instance."
  default     = false
  type        = bool
}
