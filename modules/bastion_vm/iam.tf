######
# SA #
######

module "bastion_service_account" {
  source       = "github.com/GoogleCloudPlatform/cloud-foundation-fabric//modules/iam-service-account?ref=v29.0.0"
  project_id   = var.project_id
  name         = var.bastion_vm_sa_name
  display_name = "Terraform managed service account for Bastion VM"

  service_account_create = var.service_account_create
  iam_bindings_additive  = var.iam_bindings_additive
}

##########
# SA IAM #
##########

data "google_iam_policy" "bastion_iam_policy" {
  binding {
    # Grant least privilege to compute SA
    role = "roles/compute.instanceAdmin.v1"
    members = [
      "serviceAccount:${module.bastion_service_account.email}"
    ]
  }
}

resource "google_compute_instance_iam_policy" "bastion_compute_instance_policy" {
  project       = var.project_id
  zone          = var.compute_zone
  instance_name = var.bastion_name
  policy_data   = data.google_iam_policy.bastion_iam_policy.policy_data

  depends_on = [module.bastion]
}
