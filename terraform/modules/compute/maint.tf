# The Control Plane (Managed by Google)
resource "google_container_cluster" "primary" {
  name     = var.cluster_name
  location = var.zone

  # We remove the default node pool to create a tailored one below
  remove_default_node_pool = true
  initial_node_count       = 1
  network                  = var.network
  subnetwork               = var.subnetwork

}

# The Worker Nodes (Where your apps actually run)
resource "google_container_node_pool" "primary_nodes" {
  name       = "${var.cluster_name}-node-pool"
  location   = var.zone
  cluster    = google_container_cluster.primary.name
  node_count = var.node_count

  node_config {
    machine_type = var.machine_type

    # Uses the Service Account created in your iam_registry module
    service_account = var.service_account_email
    oauth_scopes    = ["https://www.googleapis.com/auth/cloud-platform"]
  }
}