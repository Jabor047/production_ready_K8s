variable "project" {
  description = "Name of the GCP project where the components will be deployed"
  type        = string
}

variable "service_account_name" {
  description = "Name of the service account to be created"
  type        = string
}

variable "display_name" {
  description = "Display name of the service account to be created"
  type        = string
}

variable "roles" {
  description = "Roles to be assigned to the service account"
  type        = list(string)
}