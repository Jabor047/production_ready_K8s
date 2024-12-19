resource "google_service_account" "service_account" {
  project      = var.project
  account_id   = var.service_account_name
  display_name = var.display_name
}

resource "google_project_iam_member" "service_account_iam" {
  for_each = toset(var.roles)
  project  = var.project
  role     = "roles/${each.key}"
  member   = "serviceAccount:${google_service_account.service_account.email}"

  depends_on = [google_service_account.service_account]
}

