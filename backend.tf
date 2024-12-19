terraform {
  backend "gcs" {
    bucket = "kevin-sandbox-dev-tfstate"
    prefix = "terraform_state"
  }
}