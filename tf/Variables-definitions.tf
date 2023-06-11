variable "project_id" {
  type        = string
  description = "the id of the project"
}

variable "zone" {
  type        = string
  description = "the zone of the cluster"
}

variable "region" {
  type        = string
  description = "the region of the cluster"
}

## compute instance variables
variable "machine_type" {
  type        = string
  default     = "e2-medium"
  description = "The machine type of the created instances"
}

variable "disk_size" {
  type        = number
  default     = 50
  description = "The size of disk for the node instances"
}

variable "image" {
  type        = string
  default     = "ubuntu-os-cloud/ubuntu-1804-lts"
  description = "The image for the jump host"
}

variable "internal_ip" {
  type        = string
  description = "The internal ip address for the jump host"
}

## GKE Variables
variable "gke_username" {
  type        = string
  default     = ""
  description = "gke username"
}

variable "gke_password" {
  type        = string
  default     = ""
  description = "gke password"
}

variable "gke_num_nodes" {
  default     = 2
  description = "number of gke nodes"
}
