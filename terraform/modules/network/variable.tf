variable "network_name" {
  type        = string
  description = "Name of the VPC"
}

variable "region" {
  type        = string
}

variable "cidr_range" {
  type        = string
  description = "IP range for the subnet"
}