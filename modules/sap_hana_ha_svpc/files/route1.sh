#!/bin/bash
DEPLOY_URL="https://storage.googleapis.com/sapdeploy/dm-templates"
source /dev/stdin <<< "$(curl -s ${DEPLOY_URL}/lib/sap_lib_main.sh)"
source /dev/stdin <<< "$(curl -s ${DEPLOY_URL}/lib/sap_lib_hdb.sh)"
main::get_settings
hdb::check_settings
SAPSID=$(echo "${VM_METADATA[sap_hana_sid]}" | tr '[:upper:]' '[:lower:]')
crm configure property maintenance-mode="true"
curl https://storage.googleapis.com/customdeploy/pacemaker-gcp/route -o /usr/lib/ocf/resource.d/gcp/route
chmod +x /usr/lib/ocf/resource.d/gcp/route
crm configure delete rsc_vip_gcp-primary
crm configure primitive rsc_vip_gcp-primary ocf:gcp:route op monitor interval="60s" timeout="60s" op start interval="0" timeout="300s" op stop interval="0" timeout="300s" params route_ip=${VM_METADATA[sap_vip]} route_name=route-$SAPSID-hdb${VM_METADATA[sap_hana_instance_number]} route_network=$VM_NETWORK vpc_project=$VM_NETWORK_PROJECT gcloud_path=/usr/bin/gcloud logging="yes" meta priority=10
crm configure delete rsc_vip_int-primary
crm configure primitive rsc_vip_int-primary IPaddr2 params ip="${VM_METADATA[sap_vip]}" cidr_netmask=32 nic="eth0" op monitor interval=10s
crm configure group g-primary rsc_vip_int-primary rsc_vip_gcp-primary
cat <<EOF > /tmp/cluster.tmp
	colocation col_saphana_ip_${VM_METADATA[sap_hana_sid]}_HDB${VM_METADATA[sap_hana_instance_number]} 4000: g-primary:Started \
        msl_SAPHana_${VM_METADATA[sap_hana_sid]}_HDB${VM_METADATA[sap_hana_instance_number]}:Master
EOF
crm configure load update /tmp/cluster.tmp
crm configure property maintenance-mode="false"


chmod +x route1.sh
source route1.sh
