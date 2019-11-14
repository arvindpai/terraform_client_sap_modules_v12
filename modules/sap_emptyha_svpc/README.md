
# SAP EMPTY HA  SVPC Submodule

This module deals with SAP EMPTY HA SVPC configuration and deployment.

## Usage

The resources/services/activations/deletions that this module will create/trigger are:

- Create Primary and Secondary Compute Instance that will host SAP Empty HA.
- Create a Static IP Address for the two Compute Instance's.
- Create 2 Persistent Disks to host SAP Empty HA's File systems on primary and secondary nodes.

You can go in the [examples](../../examples) folder complete working example. However, here's an example of how to use the module in a main.tf file.

```hcl

module "gcp_sap_emptyha_svpc" {
source                      = "../../modules/sap_emptyha_svpc"
post_deployment_script   = "${var.post_deployment_script}"
subnetwork               = "${var.subnetwork}"
linux_image_family       = "${var.linux_image_family}"
linux_image_project      = "${var.linux_image_project}"
instance_type            = "${var.instance_type}"
network_tags             = "${var.network_tags}"
project_id               = "${var.project_id}"
subnetwork_project       = "${var.subnetwork_project}"
region                   = "${var.region}"
service_account_email    = "${var.service_account_email}"
boot_disk_size           = "${var.boot_disk_size}"
boot_disk_type           = "${var.boot_disk_type}"
autodelete_disk          = "true"
sap_deployment_debug     = "false"
primary_instance_name    = "${var.primary_instance_name}"
secondary_instance_name  = "${var.secondary_instance_name}"
primary_zone             = "${var.primary_zone}"
secondary_zone           = "${var.secondary_zone}"
sap_vip                  = "${var.sap_vip}"
sap_vip_secondary_range  = "${var.sap_vip_secondary_range}"
primary_instance_ip      = "${var.primary_instance_ip}"
secondary_instance_ip    = "${var.secondary_instance_ip}"
public_ip                = "${var.public_ip}"
sap_vip_internal_address = "${var.sap_vip_internal_address}"
  }

```
## Requirements

Make sure you've gone through the root [Requirement Section](../../README.md#requirements)

### SAP HANA Software
 Follow instructions [here](https://cloud.google.com/solutions/sap/docs/sap-hana-deployment-guide#creating_a_cloud_storage_bucket_for_the_sap_hana_ha_installation_files) to properly Download SAP HANA from the SAP Marketplace, and upload it to a GCS bucket.


### Configure Service Account for identifying the Compute instances
The compute instances created by this submodule will need to download SAP HANA from a GCS bucket in order install it. Follow the instructions below to ensure a successful installation:

 1. [Create a new service account](https://cloud.google.com/iam/docs/creating-managing-service-accounts)
 2. Grant this new service account the following permissions on the bucket where you uploaded SAP HANA installation file:
    - roles/storage.objectViewer

 You may use the following gcloud commands:
   `gcloud projects add-iam-policy-binding <project-id> --member=serviceAccount:<service-account-email> --role=roles/storage.objectViewer`

3. When configuring the module, use this newly created service account's email, to set the `service_account_email` input variable.

### Post deployment script
If you need to run a post deployment script, the script needs to be accessible via a **https:// or gs:// URl**.
It is the recommended way is to use a GCS Bucket in the following way.:

1. Upload the to a GCS bucket.
2. Make sure the service account attached to the instance has the following permissions on the bucket:
   - roles/storage.objectViewer
     - Note that this permission should already be granted if the bucket is in the same project as the one where you created the service account previously.

3. Set the post_deployment_script input to the gs:// link to your script. (i.e gs://<bucket_name>/<my_script>)


[^]: (autogen_docs_start)

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| autodelete\_disk | Whether the disk will be auto-deleted when the instance is deleted. | string | `"false"` | no |
| boot\_disk\_size | Root disk size in GB | string | n/a | yes |
| boot\_disk\_type | The GCE data disk type. May be set to pd-standard (for PD HDD) or pd-ssd. | string | n/a | yes |
| instance\_type | The GCE instance/machine type. | string | n/a | yes |
| linux\_image\_family | GCE image family. | string | n/a | yes |
| linux\_image\_project | Project name containing the linux image. | string | n/a | yes |
| network\_tags | List of network tags to attach to the instance. | list | `<list>` | no |
| post\_deployment\_script | SAP post deployment script | string | n/a | yes |
| primary\_instance\_ip | Primary instance ip address | string | n/a | yes |
| primary\_instance\_name | A unique name for the resource, required by GCE. Changing this forces a new resource to be created. | string | n/a | yes |
| primary\_zone | The primary zone that the instance should be created in. | string | n/a | yes |
| project\_id | The ID of the project in which the resources will be deployed. | string | n/a | yes |
| region | Region to deploy the resources. Should be in the same region as the zone. | string | n/a | yes |
| sap\_deployment\_debug | Debug flag for SAP HANA deployment. | string | n/a | yes |
| sap\_vip | SAP VIP | string | n/a | yes |
| sap\_vip\_internal\_address | Name of static IP adress to add to the instance's access config. | string | n/a | yes |
| sap\_vip\_secondary\_range | SAP seconday VIP range | string | n/a | yes |
| secondary\_instance\_ip | Secondary instance ip address | string | n/a | yes |
| secondary\_instance\_name | A unique name for the resource, required by GCE. Changing this forces a new resource to be created. | string | n/a | yes |
| secondary\_zone | The secondary zone that the instance should be created in. | string | n/a | yes |
| service\_account\_email | Email of service account to attach to the instance. | string | n/a | yes |
| startup\_script\_1 | Startup script to install SAP HANA. | string | n/a | yes |
| startup\_script\_2 | Startup script to install SAP HANA. | string | n/a | yes |
| subnetwork | Compute Engine instance name | string | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| primary\_instance\_machine\_type | Primary GCE instance/machine type. |
| primary\_instance\_name | Name of sap primary instance |
| primary\_zone | Compute Engine primary instance deployment zone |
| secondary\_instance\_machine\_type | Secondary GCE instance/machine type. |
| secondary\_instance\_name | Name of sap secondary instance |
| secondary\_zone | Compute Engine secondary instance deployment zone |

[^]: (autogen_docs_end)
