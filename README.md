# terraform-google-sap

This module is a collection of multiple opinionated submodules to deploy SAP Products.
Below is the list of available submodules:
## Standalone Modules
- [SAP HANA](./modules/sap_hana/README.md)
- [SAP HANA HA](./modules/sap_hana_ha/README.md)
- [SAP EMTPYHA](./modules/sap_emptyha/README.md)
- [SAP HANA SCALEOUT](./modules/sap_hana_scaleout/README.md)
- [NETWEAVER](./modules/netweaver/README.md)
- [SAP ASE](./modules/sap_ase/README.md)
- [SAP DB2](./modules/sap_db2/README.md)
- [SAP ILB](./modules/ILB/README.md)
- [SAP APP DR](./modules/sap_app_dr/README.md)
## SVPC Modules
- [SAP HANA SVPC](./modules/sap_hana_svpc/README.md)
- [NETWEAVER SVPC](./modules/netweaver_svpc/README.md)
- [SAP HANA HA SVPC](./modules/sap_hana_ha_svpc/README.md)
- [SAP HANA HA ROUTE SVPC](./modules/sap_hana_ha_route_svpc/README.md)
- [SAP EMPTYHA SVPC](./modules/sap_emptyha_svpc/README.md)
- [SAP HANA SCALEOUT SVPC](./modules/sap_hana_scaleout_svpc/README.md)
- [SAP ASE SVPC](./modules/sap_ase_svpc/README.md)
- [SAP DB2 SVPC](./modules/sap_db2_svpc/README.md)
- [SAP APP DR SVPC](./modules/sap_app_dr_svpc/README.md)
## Standalone Modules with Network
- [SAP HANA WITH NETWORK](./modules/sap_hana_with_network/README.md)
- [SAP HANA HA WITH NETWORK](./modules/sap_hana_ha_with_network/README.md)
- [NETWEAVER WITH NETWORK](./modules/netweaver_with_network/README.md)
## SVPC modules with Network
- [SAP HANA SVPC WITH NETWORK](./modules/sap_hana_svpc_with_network/README.md)
- [SAP HANA HA SVPC WITH NETWORK](./modules/sap_hana_ha_svpc_with_network/README.md)
- [NETWEAVER SVPC WITH NETWORK](./modules/netweaver_svpc_with_network/README.md)


Each submodules have their own usage documented in the [modules](./modules) folder.

For example, see the [SAP HANA Usage Section](./modules/sap_hana/README.md#Usage).

Functional examples are included in the
[examples](./examples/) directory.

[^]: (autogen_docs_start)

[^]: (autogen_docs_end)

## Requirements

These sections describe requirements for using this module.

### Software

The following dependencies must be available:

- [Terraform][terraform] v0.12
- [Terraform Provider for GCP][terraform-provider-gcp] plugin v2.6.0

## Using Credentials

export GOOGLE_APPLICATION_CREDENTIALS="[PATH]"

### For example :

export GOOGLE_APPLICATION_CREDENTIALS="/home/user/Downloads/[FILE_NAME].json"

### Service Account

A service account with the following roles must be used to provision
the resources of each submodule:

- Compute Admin: `roles/compute.admin`

Please refer to the documentation of specific submodules located in the [modules](./modules/) folder for additional requirements for the service account.

The [Project Factory module][project-factory-module] and the
[IAM module][iam-module] may be used in combination to provision a
service account with the necessary roles applied.

### APIs

A project with the following APIs enabled must be used to host the
resources of this module:

- Compute Engine API: `compute.googleapis.com`

The [Project Factory module][project-factory-module] can be used to
provision a project with the necessary APIs enabled.

## Contributing

Refer to the [contribution guidelines](./CONTRIBUTING.md) for
information on contributing to this module.

[iam-module]: https://registry.terraform.io/modules/terraform-google-modules/iam/google
[project-factory-module]: https://registry.terraform.io/modules/terraform-google-modules/project-factory/google
[terraform-provider-gcp]: https://www.terraform.io/docs/providers/google/index.html
[terraform]: https://www.terraform.io/downloads.html
