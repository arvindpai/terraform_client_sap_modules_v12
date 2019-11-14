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


variable "region" {
  default = "us-central1"
}

variable "region_zone" {
  default = "us-central1-a"
}

variable "region_zone_2" {
  default = "us-central1-b"
}

variable "project_id" {
  description = "The ID of the Google Cloud project"
}

variable "subnetwork" {
  description = "The name or self_link of the subnetwork where the instance will be deployed. The subnetwork must exist in the same region this instance will be created in."
}

variable "network" {
  description = "The name or self_link of the network where the instance will be deployed. The network must exist in the same region this instance will be created in."
}
