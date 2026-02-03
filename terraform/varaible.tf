variable "project_id" {
  type = string
}

variable "region" {
  type    = string
  default = "us-central1"
}

variable "zone_a" {
  type    = string
  default = "us-central1-a"
}

variable "zone_b" {
  type    = string
  default = "us-central1-b"
}

variable "gke_node_service_account_email" {
  type = string
}