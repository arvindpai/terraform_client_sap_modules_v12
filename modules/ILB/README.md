
# ILB Standalone Submodule

This module is handles opinionated Netweaver configuration and deployment.

## Usage

The resources/services/activations/deletions that this module will create/trigger are:

- Create a Compute Instance that will host ILB
- Create a Static IP Addresses for the Compute Instance
- Create a 2 Persitent Disks to host Netweaver's File systems

You can go in the [examples](../../examples) folder complete working example. However, here's an example of how to use the module in a main.tf file.

```hcl

module "gcp_ilb" {
  source      = "../../modules/ILB"
  subnetwork  = "${var.subnetwork}"
  network     = "${var.network}"
  region      = "${var.region}"
  project_id  = "${var.project_id}"
  region_zone = "${var.region_zone}"
}

```
## Requirements

Make sure you've gone through the root [Requirement Section](../../README.md#requirements)


### Configure Service Account for identifying the Compute instance
The compute instance created by this submodule will need to download SAP HANA from a GCS bucket in order install it. Follow the instructions below to ensure a successful installation:

 1. [Create a new service account](https://cloud.google.com/iam/docs/creating-managing-service-accounts)
 2. Grant this new service account the following permissions on the bucket where you uploaded netweaver file:
    - Storage Object Viewer: `roles/storage.objectViewer`

  You may use the following gcloud command:
  `gcloud projects add-iam-policy-binding <project-id> --member=serviceAccount:<service-account-email> --role=roles/storage.objectViewer`

3. When configuring the module, use this newly created service account's email, to set the `service_account_email` input variable.

[^]: (autogen_docs_end)
