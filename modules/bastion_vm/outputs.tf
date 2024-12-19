###########
# Outputs #
###########

output "bastion_vm_sa_email" {
  value       = module.bastion_service_account.email
  description = "The email of the service account associated with the bastion"
}
