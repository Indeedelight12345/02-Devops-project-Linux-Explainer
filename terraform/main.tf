
module "network" {
  source       = "./modules/network"
  network_name = "gke-vpc"
  region       = var.region
  cidr_range   = "10.10.0.0/24"
}


module "iam_registry" {
  source     = "./modules/iam_registry"
  project_id = var.project_id
  region     = var.region
}


module "cluster_one" {
  source                = "./modules/compute"
  cluster_name          = "cluster-one"
  node_count            = 1
  machine_type          = "e2-medium"
  zone                  = "us-central1-a"
  network               = module.network.network_name
  subnetwork            = module.network.subnet_self_link
  service_account_email = module.iam_registry.nodes_sa_email
}


module "cluster_two" {
  source                = "./modules/compute"
  cluster_name          = "cluster-two"
  node_count            = 1
  machine_type          = "e2-medium"
  zone                  = "us-central1-b"
  network               = module.network.network_name
  subnetwork            = module.network.subnet_self_link
  service_account_email = module.iam_registry.nodes_sa_email
}