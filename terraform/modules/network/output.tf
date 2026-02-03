output "network_name" {
  description = "The name of the VPC"
  value       = google_compute_network.vpc.name
}

output "subnet_self_link" {
  description = "The self-link of the subnet"
  value       = google_compute_subnetwork.subnet.self_link
}