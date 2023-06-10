variable "project_id" {
  type = string
  description = "the id of the project"
}

variable "project_name" {
  type = string
  description = "the name of the project"
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
  default     = 3
  description = "number of gke nodes"
}
