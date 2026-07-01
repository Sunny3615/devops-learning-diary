variable "resource_group_location" {
  type        = string
  default     = "West Europe"
  description = "Location of the resource group."
}

variable "resource_group_name" {
  type        = string
  default     = "rg-tf-network-exe"
  description = "The name of the resource group."
}

variable "my_public_ip_cidr" {
  type        = string
  description = "My public IP address in CIDR format for SSH access."
}