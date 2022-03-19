#############################
## Application - Variables ##
#############################

variable "environment" {
  type        = string
  description = "This variable defines the environment to be built"
}

variable "location" {
  type        = string
  description = "Azure region where the resource group will be created"
  default     = "eastus2"
}

variable "owner_name" {
  type        = string
  description = "Specify the owner of the resource"
}