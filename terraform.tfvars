gke_cluster_name           = "prod-level-gke-cluster"
region                     = "europe-west2"
project                    = "dt-kevin-sandbox-dev"
gke_vpc_subnet_cidr        = "10.10.10.0/24"
gke_ip_range_pods          = "192.168.0.0/20"
gke_ip_range_services      = "192.168.20.0/24"
master_auth_subnet_cidr    = "10.10.20.0/24"
zones                      = ["europe-west2-a", "europe-west2-b", "europe-west2-c"]
gke_master_ipv4_cidr_block = "172.16.0.32/28"
authorized_sources_ranges = {
  cidr_block   = "10.10.20.0/24",
  display_name = "Master Auth Network"
}
service_accounts = {
  "gke-sa" : {
    display_name = "GKE's Service Account"
    roles        = ["artifactregistry.reader", "iam.serviceAccountUser"]
  },
  "kube-deploy-sa" : {
    display_name = "Service account to deploy kubernetes manifests"
    roles        = ["compute.osLogin", "container.developer"]
  }
}
compute_zone = "europe-west2-c"
bastion_name = "gke-vm"

service_account_create = true
bastion_vm_sa_name     = "bastion-sa"

enable_oslogin     = "TRUE"
# bastion_ip         = "10.0.1.2"    # IP inside of the subnetwork CIDR
members = ["user:kevin.karobia@gmail.com"]
