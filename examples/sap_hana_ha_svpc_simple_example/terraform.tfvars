primary_instance_name = "sap-hana-ha-terra-1"

primary_instance_ip = "gcp-primary-instance-ip"

secondary_instance_ip = "gcp-secondary-instance-ip"

sap_vip_internal_address = "sap-vip-internal-address"

secondary_instance_name = "sap-hana-ha-terra-2"

instance_type = "n1-highmem-16"

primary_zone = "us-central1-b"

secondary_zone = "us-central1-a"

subnetwork = "sap-dev-demo"

service_account_email = "38493345447-compute@developer.gserviceaccount.com"

subnetwork_project = "hana-host-254820"

project_id = "hana-service"

region = "us-central1"

linux_image_family = "sles-12-sp3-sap"

linux_image_project = "suse-sap-cloud"

post_deployment_script = ""

sap_hana_sid = "D01"

sap_hana_instance_number = 00

sap_hana_sidadm_password = "Google123"

sap_hana_system_password = "Google123"

sap_hana_sidadm_uid = 900

sap_hana_sapsys_gid = 900

sap_vip = "10.0.0.18"

sap_vip_secondary_range = ""

boot_disk_size = 300

boot_disk_type = "pd-ssd"

network_tags = ["ssh", "http-server", "https-server"]

sap_hana_deployment_bucket = "hana-software/hana-gcp-20"

public_ip = true
