

output "repo_name" {
  value = google_artifact_registry_repository.my_repo.name
}

output "nodes_sa_email" {
  value = google_service_account.gke_nodes_sa.email
}

output "github_sa_key" {
  value     = google_service_account_key.mykey.private_key
  sensitive = true
}
