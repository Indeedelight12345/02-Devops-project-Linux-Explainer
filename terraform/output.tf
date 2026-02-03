output "cluster_one_endpoint" {
  value = module.cluster_one.cluster_endpoint
}

output "cluster_two_endpoint" {
  value = module.cluster_two.cluster_endpoint
}

output "gcp_sa_key_for_github" {
  value     = module.iam_registry.github_sa_key
  sensitive = true
}