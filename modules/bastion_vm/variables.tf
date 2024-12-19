###########
# General #
###########

variable "project_id" {
  description = "The ID of the project to deploy resources in"
  type        = string
}

variable "compute_zone" {
  description = "The zone to deploy the VM in"
  type        = string
  default     = "europe-west2-c"
}

###################
# Service Account #
###################

variable "service_account_create" {
  description = "Create service account. When set to false, uses a data source to reference an existing service account"
  type        = bool
  default     = false
}

variable "bastion_vm_sa_name" {
  description = "The name of the service account to be used with the VM"
  type        = string
}

variable "iam_bindings_additive" {
  description = "Individual additive IAM bindings on the service account. Keys are arbitrary"
  type = map(object({
    member = string
    role   = string
    condition = optional(object({
      expression  = string
      title       = string
      description = optional(string)
    }))
  }))
  nullable = false
  default  = {}
}

###########
# Bastion #
###########

variable "bastion_name" {
  description = "The name of the VM"
  type        = string
}

variable "instance_type" {
  description = "The instance type of the VM"
  type        = string
  default     = "e2-standard-4"
}

variable "boot_disk_size" {
  description = "The size of the boot disk"
  type        = number
  default     = 20
}

variable "enable_oslogin" {
  description = "The ability to control access to the VM instances based on IAM permissions (e.g., for ssh)"
  type        = string
  default     = ""
}

variable "tags" {
  description = "Instance network tags for firewall rule targets"
  type        = list(string)
  default     = ["allow-iap"]
}

###########
# Network #
###########

variable "bastion_network" {
  description = "The VPC network to deploy the VM in"
  type        = string
}

variable "bastion_subnetwork" {
  description = "The VPC subnetwork to deploy the VM in"
  type        = string
}

variable "members" {
  description = "Users / Service Accounts / groups that can ssh to the bastion via IAP"
  default     = []
}
