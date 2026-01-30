variable "region" {
  description = "OVH region for the KMS resource ('eu-west-rbx')."
  type        = string
  default     = "eu-west-rbx"
}

variable "instance_name" {
  description = "Instance name."
  type        = string
}

variable "description" {
  description = "Description of the PostgreSQL instance."
  type        = string
}

variable "plan" {
  description = "Plan for the PostgreSQL instance."
  type        = string
}

variable "flavor" {
  description = "Flavor for the PostgreSQL instance."
  type        = string
}

variable "postgres_version" {
  description = "PostgreSQL version."
  type        = string
}

variable "network_id" {
  description = "Network ID for the PostgreSQL instance."
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID for the PostgreSQL instance."
  type        = string
}

variable "disk_size" {
  description = "Disk size in Gb for the PostgreSQL instance."
  type        = number
}

variable "node_count" {
  description = "Number of nodes for the PostgreSQL instance."
  type        = number
}
