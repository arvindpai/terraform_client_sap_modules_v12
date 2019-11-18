
# SAP ASE SVPC Submodule

This module handles opinionated SAP ASE SVPC configuration and deployment.

## Usage

The resources/services/activations/deletions that this module will create/trigger are:

- Create a Compute Instance that whill host SAP ASE SVPC
- Create a Static IP Adresse for the Compute Instance
- Create a 2 Persistent Disks to host SAP ASE's File systems

You can go in the [examples](../../examples) folder complete working example. However, here's an example of how to use the module in a main.tf file.

```hcl

module "gcp_sap_ase_svpc" {
  source                 = "../../modules/sap_ase_svpc"
  subnetwork            = "${var.subnetwork}"
  linux_image_family    = "${var.linux_image_family}"
  linux_image_project   = "${var.linux_image_project}"
  instance_name         = "${var.instance_name}"
  instance_type         = "${var.instance_type}"
  zone                  = "${var.zone}"
  network_tags          = "${var.network_tags}"
  project_id            = "${var.project_id}"
  subnetwork_project    = "${var.subnetwork_project}"
  region                = "${var.region}"
  service_account_email = "${var.service_account_email}"
  boot_disk_size        = "${var.boot_disk_size}"
  boot_disk_type        = "${var.boot_disk_type}"
  autodelete_disk       = "true"
  pd_ssd_size           = "${var.pd_ssd_size}"
  usr_sap_size          = "${var.usr_sap_size}"
  sap_mnt_size          = "${var.sap_mnt_size}"
  swap_size             = "${var.swap_size}"
  aseSID                = "${var.aseSID}"
  asesidSize            = "${var.asesidSize}"
  asediagSize           = "${var.asediagSize}"
  asesaptempSize        = "${var.asesaptempSize}"
  asesapdataSize        = "${var.asesapdataSize}"
  aselogSize            = "${var.aselogSize}"
  asebackupSize         = "${var.asebackupSize}"
  asesapdataSSD         = "${var.asesapdataSSD}"
  aselogSSD             = "${var.aselogSSD}"
  sap_ase_sid           = "${var.sap_ase_sid}"
  instance_count_master = "${var.instance_count_master}"
  public_ip             = "${var.public_ip}"
  }

```
## Requirements

Make sure you've gone through the root [Requirement Section](../../README.md#requirements)


### Configure Service Account for identifying the Compute instance
The compute instance created by this submodule will need to download SAP HANA from a GCS bucket in order install it. Follow the instructions below to ensure a successful installation:

 1. [Create a new service account](https://cloud.google.com/iam/docs/creating-managing-service-accounts)
 2. Grant this new service account the following permissions on the bucket where you uploaded SAP ASE installation file:
    - Storage Object Viewer: `roles/storage.objectViewer`

  You may use the following gcloud command:
  `gcloud projects add-iam-policy-binding <project-id> --member=serviceAccount:<service-account-email> --role=roles/storage.objectViewer`

3. When configuring the module, use this newly created service account's email, to set the `service_account_email` input variable.

### Post deployment script
If you need to run a post deployment script, the script needs to be accessible via a **https:// or gs:// URl**.
The recommended way is to use a GCS Bucket in the following way.:

1. Upload the post-deployment-script to a GCS bucket.
2. Grant the following role on the bucket to the service account attached to the instance if the bucket is not in the same project as the service account:
   - Storage Object Viewer: `roles/storage.objectViewer`

 3. Set the value of the `post_deployment_script` input to the URI of the post-deployment script storage bucket object, like `gs://<bucket_name>/<script_name>`.


[^]: (autogen_docs_start)

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| aseSID | The database instance ID. | string | n/a | yes |
| asebackupSize | The size of the /sybasebackup volume. If set to 0 or omitted, no disk is created. | string | n/a | yes |
| asediagSize | The size of /sybase/[DBSID]/sapdiag, which holds the diagnostic tablespace for SAPTOOLS. | string | n/a | yes |
| aselogSSD | The SSD toggle for the log drive. If set to true, the log disk will be SSD. | string | n/a | yes |
| aselogSize | The size of /sybase/[DBSID]logdir, which holds the database transaction logs. | string | n/a | yes |
| asesapdataSSD | The SSD toggle for the data drive. If set to true, the data disk will be SSD. | string | n/a | yes |
| asesapdataSize | The size of /sybase/[DBSID]/sapdata, which holds the database data files. | string | n/a | yes |
| asesaptempSize | The size of /sybase/[DBSID]/saptmp, which holds the database temporary table space. | string | n/a | yes |
| asesidSize | The size in GB of /sybase/[DBSID], which is the root directory of the database instance. In the deployed VM, this volume is labeled ASE. | string | n/a | yes |
| autodelete\_disk | Whether the disk will be auto-deleted when the instance is deleted. | string | `"true"` | no |
| boot\_disk\_size | Root disk size in GB | string | n/a | yes |
| boot\_disk\_type | The GCE boot disk type. May be set to pd-standard (for PD HDD) or pd-ssd. | string | `"pd-ssd"` | no |
| device | Device name | string | `"boot"` | no |
| device\_0 | Device name | string | `"usrsap"` | no |
| device\_1 | Device name | string | `"sapmnt"` | no |
| device\_2 | Device name | string | `"swap"` | no |
| device\_3 | Device name | string | `"asesid"` | no |
| device\_4 | Device name | string | `"asesapdata"` | no |
| device\_5 | Device name | string | `"aselog"` | no |
| device\_6 | Device name | string | `"asesaptemp"` | no |
| device\_7 | Device name | string | `"asesapdiag"` | no |
| device\_8 | Device name | string | `"asebackup"` | no |
| disk\_type | The GCE data disk type. May be set to pd-standard (for PD HDD) or pd-ssd. | string | n/a | yes |
| instance\_count\_master | Compute Engine instance count | string | n/a | yes |
| instance\_name | A unique name for the resource, required by GCE. Changing this forces a new resource to be created. | string | n/a | yes |
| instance\_type | The GCE instance/machine type. | string | n/a | yes |
| linux\_image\_family | GCE linux image family. | string | n/a | yes |
| linux\_image\_project | Project name containing the linux image. | string | n/a | yes |
| network\_tags | List of network tags to attach to the instance. | list | `<list>` | no |
| pd\_ssd\_size | Persistent disk size in GB | string | `""` | no |
| post\_deployment\_script | SAP HANA post deployment script. Must be a gs:// or https:// link to the script. | string | `""` | no |
| project\_id | The ID of the project in which the resources will be deployed. | string | n/a | yes |
| region | Region to deploy the resources. Should be in the same region as the zone. | string | n/a | yes |
| sap\_ase\_sid | Sap Ase SID. | string | n/a | yes |
| sap\_mnt\_size | SAP mount size | string | n/a | yes |
| service\_account\_email | Email of service account to attach to the instance. | string | n/a | yes |
| startup\_script | Startup script to install SAP HANA. | string | n/a | yes |
| subnetwork | The name or self_link of the subnetwork where the isntance will be deployed. The subnetwork must exist in the same region this instance will be created in. | string | n/a | yes |
| swap\_size | SWAP Size | string | n/a | yes |
| usr\_sap\_size | USR SAP size | string | n/a | yes |
| zone | The zone that the instance should be created in. | string | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| instance\_machine\_type | Primary GCE instance/machine type. |
| instance\_name | Name of sap ase instance |
| zone | Compute Engine instance deployment zone |

[^]: (autogen_docs_end)
