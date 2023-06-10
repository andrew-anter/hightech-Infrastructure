variable "project_id" {
  type = string
  description = "the id of the project"
}

variable "zone" {
  type = string
  description = "the zone of the cluster"
}

variable "region" {
  type = string
  description = "the region of the cluster"
}


## GKE Variables
variable "gke_username" {
  default     = ""
  description = "gke username"
}

variable "gke_password" {
  default     = ""
  description = "gke password"
}

variable "gke_num_nodes" {
  default     = 2
  description = "number of gke nodes"
}
