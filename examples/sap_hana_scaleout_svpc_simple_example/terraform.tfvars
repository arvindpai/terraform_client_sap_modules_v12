instance_name = "uscl6hdbhso"

instance_type = "n1-highmem-16"

zone = "us-central1-c"

subnetwork = "sap-dev-demo"

project_id = "hana-service"

subnetwork_project = "hana-host-254820"

region = "us-central1"

linux_image_family = "sles-12-sp3-sap"

linux_image_project = "suse-sap-cloud"

sap_hana_sidadm_password = "Google123"

sap_hana_system_password = "Google123"

sap_hana_sid = "D10"

sap_hana_instance_number = 10

sap_hana_sidadm_uid = 900

sap_hana_sapsys_gid = 900

instance_count_worker = 2

sap_hana_scaleout_nodes = 2

instance_count_master = 1

autodelete_disk = "true"

boot_disk_size = 450

boot_disk_type = "pd-ssd"

disk_type_1 = "pd-standard"

service_account_email = "38493345447-compute@developer.gserviceaccount.com"

network_tags = ["ssh", "http-server", "https-server"]

sap_hana_deployment_bucket = "hana-gcp-20/hana20sps03"
