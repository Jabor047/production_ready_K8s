module "instance_template" {
  source  = "terraform-google-modules/vm/google//modules/instance_template"
  version = "11.1.0"

  project_id   = var.project
  machine_type = var.machine_type
  network   = var.network
  subnetwork_project = var.project
  subnetwork = var.subnetwork
  region = var.region

  service_account = {
    email  = var.sa_email
    scopes = ["cloud-platform"]
  }

  metadata = {
    enable_oslogin = "TRUE"
  }

  source_image_family  = var.source_image_family
  source_image_project = var.source_image_project

  startup_script = file("${path.module}/bootstrap_proxy.sh")
}

resource "google_compute_instance_from_template" "gke_vm" {
  name    = var.instance
  project = var.project
  zone    = var.zone

  network_interface {
    subnetwork = var.subnetwork
  }
  source_instance_template = module.instance_template.self_link
}

resource "google_project_iam_member" "os_loging_binding" {
  for_each = toset(var.members)
  project  = var.project
  role     = "iap.tunnelResourceAccessor"
  member   = each.key
}

module "iap_tunnelling" {
  source                     = "terraform-google-modules/bastion-host/google//modules/iap-tunneling"
  fw_name_allow_ssh_from_iap = "allow-ssh-from-iap-to-tunnel"
  project                    = var.project
  network                    = var.network

  service_accounts = [var.sa_email]
  instances = [{
    name = google_compute_instance_from_template.gke_vm.name
    zone = var.zone
  }]

  members = var.members
}