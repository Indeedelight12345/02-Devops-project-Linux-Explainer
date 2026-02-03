
resource "google_artifact_registry_repository" "my_repo" {
  project       = var.project_id
  location      = var.region
  repository_id = "my-repository"
  description   = "Docker repository for CI/CD"
  format        = "DOCKER"
}


resource "google_service_account" "github_actions_sa" {
  project      = var.project_id
  account_id   = "github-actions-cicd"
  display_name = "Service Account for GitHub Actions CI/CD"
}


resource "google_service_account" "gke_nodes_sa" {
  project      = var.project_id
  account_id   = "gke-nodes-sa"
  display_name = "Custom Service Account for GKE Nodes"
}

resource "google_artifact_registry_repository_iam_member" "repo_pusher" {
  project    = var.project_id
  location   = google_artifact_registry_repository.my_repo.location
  repository = google_artifact_registry_repository.my_repo.name
  role       = "roles/artifactregistry.writer"
  member     = "serviceAccount:${google_service_account.github_actions_sa.email}"
}


resource "google_artifact_registry_repository_iam_member" "repo_reader" {
  project    = var.project_id
  location   = google_artifact_registry_repository.my_repo.location
  repository = google_artifact_registry_repository.my_repo.name
  role       = "roles/artifactregistry.reader"
  member     = "serviceAccount:${google_service_account.gke_nodes_sa.email}"
}

resource "google_service_account_key" "mykey" {
  service_account_id = google_service_account.github_actions_sa.name
}


resource "google_project_iam_member" "node_logs" {
  project = var.project_id
  role    = "roles/logging.logWriter"
  member  = "serviceAccount:${google_service_account.gke_nodes_sa.email}"
}

# Essential roles for GKE nodes to function correctly
resource "google_project_iam_member" "gke_node_system_roles" {
  for_each = toset([
    "roles/logging.logWriter",
    "roles/monitoring.metricWriter",
    "roles/monitoring.viewer",
    "roles/stackdriver.resourceMetadata.writer",
    "roles/artifactregistry.reader" # Ensure they can pull images
  ])
  project = var.project_id
  role    = each.key
  member  = "serviceAccount:${google_service_account.gke_nodes_sa.email}"
}