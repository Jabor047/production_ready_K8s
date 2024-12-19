
module "gke_sa" {
  source   = "./modules/service_accounts"
  for_each = var.service_accounts

  project              = var.project
  service_account_name = each.key
  display_name         = each.value.display_name
  roles                = each.value.roles == null ? [] : each.value.roles
}

module "gke-network" {
  source                  = "./modules/gke-vpc"
  project                 = var.project
  region                  = var.region
  gke_vpc_subnet_cidr     = var.gke_vpc_subnet_cidr
  gke_ip_range_pods       = var.gke_ip_range_pods
  gke_ip_range_services   = var.gke_ip_range_services
  master_auth_subnet_cidr = var.master_auth_subnet_cidr
}

module "gke-cluster" {
  source                     = "./modules/gke"
  gke_cluster_name           = var.gke_cluster_name
  region                     = var.region
  zones                      = var.zones
  network_name               = module.gke-network.network_name
  subnet_name                = module.gke-network.subnet_name
  gke_master_ipv4_cidr_block = var.gke_master_ipv4_cidr_block
  authorized_sources_ranges  = var.authorized_sources_ranges
}

# module "bastion_vm" {
#   source     = "./modules/bastion_vm"
#   project_id    = var.project
#   bastion_name = var.bastion_name
#   enable_oslogin = var.enable_oslogin
#   bastion_network    = module.gke-network.network_name
#   bastion_subnetwork = module.gke-network.subnet_name
#   service_account_create = var.service_account_create
#   bastion_vm_sa_name   = var.bastion_vm_sa_name
#   members = var.members
# }

module "bastion" {
  source     = "./modules/bastion"
  project    = var.project
  region     = var.region
  zone       = var.zones[0]
  network    = module.gke-network.network_name
  subnetwork = module.gke-network.subnet_name
  sa_email   = module.gke_sa["${keys(var.service_accounts)[0]}"].service_account_email
}